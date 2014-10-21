#ifndef _TOUCHTOPC_H_
#define _TOUCHTOPC_H_

#include <bb/cascades/Application>
#include "ITouchSend.h"
#include "TouchSocket.h"

class TouchToPC: public QObject
{
public:
	TouchToPC();
	~TouchToPC();

	Q_INVOKABLE
	void sendPosition(const int &x, const int &y);
	Q_INVOKABLE
	void sendButtonPress(const int &button, const int &press);
	Q_INVOKABLE
	void sendKeyPress(const QString &key);
	Q_INVOKABLE
	void send(const QString &val);
	Q_INVOKABLE
	QString getIP();
	Q_INVOKABLE
	void setIP(const QString &IP);
	Q_INVOKABLE
	void setPort(const QString &port);
	Q_INVOKABLE
	QString getPort();
	Q_INVOKABLE
	void Setup();
	Q_INVOKABLE
	void setPassword(const QString &password);
	Q_INVOKABLE
	QString getPassword();
	Q_INVOKABLE
	bool checkTime(const int &oldTime, const QTime &newTime, const int &timeDifference);
	Q_INVOKABLE
	int getTime(const QTime &time);

	QString getValueFor(const QString &objectName, const QString &defaultValue);

	bool getBValueFor(const QString &objectName, const bool &defaultValue);

	void saveValueFor(const QString &objectName, const QVariant &inputValue);

private:
Q_OBJECT

	topc::ITouchSend * sender;
};

#endif // ifndef _TOUCHTOPC_H_
