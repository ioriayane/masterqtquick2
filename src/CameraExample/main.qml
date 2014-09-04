import QtQuick 2.2
import QtQuick.Controls 1.1
import QtMultimedia 5.0
import QtQuick.Layouts 1.1
import com.example.imagecompositor 1.0

ApplicationWindow {
  visible: true
  width: 640
  height: 480
  title: qsTr("Hello World")

  ImageCompositor {
    id: compositor
    depth: 16
    folder: "d:/temp/comp"
    baseName: "c"
  }

  Camera {
    id: camera

    Component.onCompleted: {
      console.debug("availability:" + availability)
      console.debug("cameraState:" + cameraState)
      console.debug("cameraStatus:" + cameraStatus)
      console.debug("captureMode:" + captureMode)
      console.debug("zoom:" + digitalZoom)
      console.debug("lockStatus:" + lockStatus)
      console.debug("maximumDigitalZoom:" + maximumDigitalZoom)
      console.debug("maximumOpticalZoom:" + maximumOpticalZoom)
      console.debug("flash ready:" + flash.ready)

      console.debug("started")
    }

    onAvailabilityChanged: console.debug("availability:" + availability)  //カメラの稼動状態
    onCameraStateChanged: console.debug("cameraState:" + cameraState)     //カメラの状態
    onCameraStatusChanged: console.debug("cameraStatus:" + cameraStatus)  //カメラの細かい状態がわかる（スタンバイなど）
    onCaptureModeChanged: console.debug("captureMode:" + captureMode)     //カメラのモード（ファインダー表示のみ、静止画、動画モード）
    onErrorCodeChanged: console.debug("errorCode:" + errorCode)
    onErrorChanged: console.debug("error:" + error)
    onErrorStringChanged: console.debug("errorString:" + errorString)
    onError: console.debug("error:" + errorCode + "/" + errorString)
    onLockStatusChanged: console.debug("lockStatus:" + lockStatus)        //設定の状態。変更可能か不可か。フォーカスや露出の計算中か


    digitalZoom: zoomDigitalSlider.value    //デジタルズーム
    opticalZoom: zoomOpticalSlider.value    //光学ズーム
//    captureMode: Camera.CaptureViewfinder

    imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

    exposure {
      exposureCompensation: -1.0
      exposureMode: Camera.ExposurePortrait
    }

    //フラッシュの設定
    flash.mode: Camera.FlashRedEyeReduction
    flash.onReadyChanged: console.debug("flash ready:" + flash.ready)

    //カメラ画像のキャプチャ操作
    imageCapture {
      //画像をキャプチャした
      onImageCaptured: {
        compositor.append(preview)
        console.debug(preview + "," + camera.imageCapture.resolution)
        photoPreview.source = preview  // Show the preview in an Image
      }
      //画像を保存した
      onImageSaved: {
        console.debug("image saved:" + requestId + "," + path)
      }
      resolution: Qt.size(1024,768)
    }

    //動画撮影の操作
//    videoRecorder.audioEncodingMode: CameraRecorder.ConstantBitrateEncoding
    videoRecorder.audioBitRate: 128000
    videoRecorder.mediaContainer: "mp4"
    videoRecorder {
      onRecorderStateChanged: console.debug("recorder state:" + camera.videoRecorder.recorderState)
      onActualLocationChanged: console.debug("videoRecorder.actualLocation:" + camera.videoRecorder.actualLocation)
    }
  }

  //カメラのリアルタイム画像を表示
  VideoOutput {
    source: camera
    anchors.fill: parent

    //写真を撮る
    MouseArea {
      anchors.fill: parent;
      onClicked: camera.imageCapture.capture();
    }
  }

  Rectangle {
    anchors.fill: controlLayout
    color: "Black"
    opacity: 0.2
  }
  GridLayout {
    id: controlLayout
    columns: 2
    columnSpacing: 10
    rowSpacing: 5
    //ファインダービューのOn/Off
    Text { text: "FinderView:"; color: "White" }
    Button {
      text: checked ? "On" : "Off"
      checkable: true
      checked: camera.cameraState == Camera.ActiveState //ボタンを操作するまではカメラの状態で決定する
      onCheckedChanged: {
        //ファインダービューをOn/Off
        if(checked){
          camera.start()
        }else{
          camera.stop()
        }
      }
    }

    //デジタルズーム
    Text { text: "Digital Zoom(x%1):".arg(zoomDigitalSlider.value); color: "White" }
    Slider {
      id: zoomDigitalSlider
      minimumValue: 1
      maximumValue: camera.maximumDigitalZoom
      stepSize: 0.1
      value: minimumValue
    }
    //光学ズーム
    Text { text: "Optical Zoom(x%1):".arg(zoomOpticalSlider.value); color: "White" }
    Slider {
      id: zoomOpticalSlider
      minimumValue: 1
      maximumValue: camera.maximumOpticalZoom
      stepSize: 1
      value: minimumValue
    }
    //解像度
    Text { text: "Resolution:"; color: "White" }
    RowLayout {
      ExclusiveGroup {
        id: resolutionGroup
        onCurrentChanged: {
          switch(Object.num){
          case 0:
            camera.imageCapture.resolution = Qt.size(320, 240)
            break
          default:
          case 1:
            camera.imageCapture.resolution = Qt.size(640, 480)
            break
          case 2:
            camera.imageCapture.resolution = Qt.size(1024, 768)
            break
          }
        }
      }
      RadioButton {
        property int num: 0
        text: "320x240"
        exclusiveGroup: resolutionGroup
      }
      RadioButton {
        property int num: 1
        text: "640x480"
        exclusiveGroup: resolutionGroup
      }
      RadioButton {
        property int num: 2
        text: "10240x768"
        exclusiveGroup: resolutionGroup
        checked: true
      }
    }
    //録画
    Text { text: "Record:" + camera.videoRecorder.duration; color: "White" }
    Button {
      text: checked ? "stop" : "recording"
      checkable: true
      checked: camera.videoRecorder.recorderState == CameraRecorder.StoppedState
      onClicked: {
        if(checked) {
          camera.videoRecorder.record()
        }else{
          camera.videoRecorder.stop()
        }
      }
    }
  }


  //撮った写真のプレビュー
  Image {
    id: photoPreview
    visible: status == Image.Ready  //画像が準備OKになったら表示
    onVisibleChanged: {
      //表示されたら非表示までのタイマー開始
      if(visible){
        photoPreviewTimer.start()
      }
    }
    //プレビューを一定時間表示するためのタイマー
    Timer {
      id: photoPreviewTimer
      interval: 1
      onTriggered: parent.source = ""
    }
  }
}
