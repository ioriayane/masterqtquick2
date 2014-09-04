#ifndef IMAGECOMPOSITOR_H
#define IMAGECOMPOSITOR_H

#include <QObject>
#include <QImage>
#include <QUrl>

#define DEPTH_MAX   64

class ImageCompositor : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int depth READ depth WRITE setDepth NOTIFY depthChanged)
    Q_PROPERTY(int depthMax READ depthMax)
    Q_PROPERTY(QString folder READ folder WRITE setFolder NOTIFY folderChanged)
    Q_PROPERTY(QString baseName READ baseName WRITE setBaseName NOTIFY baseNameChanged)

public:
    explicit ImageCompositor(QObject *parent = 0);

    Q_INVOKABLE void append(const QUrl &url);

    int depth() const;
    void setDepth(int depth);
    int depthMax() const;
    QString folder() const;
    void setFolder(const QString &folder);
    QString baseName() const;
    void setBaseName(const QString &baseName);

signals:
    void depthChanged(int depth);
    void folderChanged(const QString &folder);
    void baseNameChanged(const QString &baseName);
    void savedCompositeImage(const QUrl &url);

public slots:

private:
    QList<QImage> imageList;
    int m_depth;
    QString m_folder;
    QString m_baseName;

    void composite();
};

#endif // IMAGECOMPOSITOR_H
