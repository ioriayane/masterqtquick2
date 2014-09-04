#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickImageProvider>
//#include <QPixmap>
#include <QDir>
#include "imagecompositor.h"
#include <QDebug>

ImageCompositor::ImageCompositor(QObject *parent) :
    QObject(parent)
  , m_depth(16)
  , m_baseName("comp")
{
}

//画像を追加
void ImageCompositor::append(const QUrl &url)
{
    qDebug() << url.toString();

    QQmlContext *qmlcontext = QQmlEngine::contextForObject(this);
    if(qmlcontext == NULL)  return;
    QQmlEngine *engine = qmlcontext->engine();
    if(engine == NULL)  return;

    if(url.scheme() != QLatin1String("image"))  return;

    QImage image;
    QQuickImageProvider::ImageType imageType = QQuickImageProvider::Invalid;
    QQuickImageProvider *provider = static_cast<QQuickImageProvider *>(engine->imageProvider(url.host()));
    QString id = url.toString(QUrl::RemoveScheme | QUrl::RemoveAuthority).mid(1);
    QSize readSize;
    QSize requestSize;
    if(provider){
        imageType = provider->imageType();
    }
    if (imageType == QQuickImageProvider::Image) {
        image = provider->requestImage(id, &readSize, requestSize);
    }

    if(image.isNull()){
        qDebug() << "null image";
        return;
    }

    //画像をリストに追加
    imageList.append(image);
    //リストがいっぱいになったら先頭から消す
    if(imageList.length() > depth()){
        imageList.removeFirst();
    }
    //合成
    composite();
}

//合成する画像の枚数のプロパティ
int ImageCompositor::depth() const
{
    return m_depth;
}
void ImageCompositor::setDepth(int depth)
{
    if(m_depth < 2)         return;
    if(m_depth == depth)    return;
    m_depth = depth;
    while(imageList.length() > depth){
        imageList.removeFirst();
    }
    emit depthChanged(depth);
}
//合成する画像の枚数の最大
int ImageCompositor::depthMax() const
{
    return DEPTH_MAX;
}
//保存先のフォルダ
QString ImageCompositor::folder() const
{
    return m_folder;
}
void ImageCompositor::setFolder(const QString &folder)
{
    if(m_folder == folder)  return;
    m_folder = folder;
    emit folderChanged(folder);
}
//ファイル名の基本名
QString ImageCompositor::baseName() const
{
    return m_baseName;
}
void ImageCompositor::setBaseName(const QString &baseName)
{
    if(m_baseName == baseName)    return;
    m_baseName = baseName;
    emit baseNameChanged(baseName);
}



//画像の合成処理
void ImageCompositor::composite()
{
    if(imageList.length() < depth())    return;

    int bytecount = imageList.at(0).byteCount();
    int w = imageList.at(0).width();
    int h = imageList.at(0).height();
    QImage image(w, h, QImage::Format_RGB32);
    const uchar *row_src[DEPTH_MAX];
    uchar *row_dest;
    unsigned int temp;

    //画像データのポインタ取得
    for(int i=0; i<imageList.length(); i++){
        row_src[i] = imageList.at(i).bits();
    }
    row_dest = image.bits();

    for(int c=0; c<bytecount; c++){
        temp = 0;
        for(int i=0; i<imageList.length(); i++){
            temp += *(row_src[i]);
            row_src[i]++;
        }
        *row_dest = static_cast<uchar>(temp / imageList.length());
        row_dest++;
    }

    //保存先があれば保存する
    QDir dir(folder());
    if(dir.exists()){
        QStringList filter;
        filter.append(baseName() + "_*.png");
        int num = 0;

        //既にファイルがあればインクリメントしてファイル名を作成
        if(dir.entryInfoList(filter, QDir::Files, QDir::Name).length() > 0){
            QStringList namesplit = dir.entryInfoList(filter).last().baseName().split("_");
            num = namesplit.at(1).toInt() + 1;
        }
        QString path = QString("%1/%2_%3.png").arg(dir.absolutePath()).arg(baseName()).arg(num, 4, 10, QChar('0'));
        //保存
        if(image.save(path)){
            emit savedCompositeImage(QUrl::fromLocalFile(path));
        }
    }
}
