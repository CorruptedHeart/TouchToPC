#include "touchtopc.h"

#include <bb/cascades/Page>
#include <bb/cascades/NavigationPane>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

TouchToPC::TouchToPC()
{
	QCoreApplication::setOrganizationName("Garth de Wet");
	QCoreApplication::setApplicationName("TouchToPC 10");

	QmlDocument *qml = QmlDocument::create("asset:///main.qml");

	if (!qml->hasErrors())
	{

		// The application Page is created from QML.
		NavigationPane *appPage = qml->createRootObject<NavigationPane>();

		if (appPage)
		{
			sender = new topc::TouchSocket();
			// Set the context property that we want to use from inside the QML. Functions that
			// are exposed via Q_INVOKABLE will be found with this property and the name of the function.
			qml->setContextProperty("touchToPCApp", this);

			QString ip = getValueFor("IPAddress", "192.168.0.3");
			QString port = getValueFor("PORT", "15000");
			QString password = getValueFor("Password", "");

			sender->Setup(ip, port, password);

			bb::cascades::Page *page = appPage->top();
			page->setProperty("ipText", ip);
			page->setProperty("portText", port);
			page->setProperty("passText", password);

			// Set the main scene for the application.
			Application::instance()->setScene(appPage);
		}
	}
}

TouchToPC::~TouchToPC()
{
	delete sender;
}

void TouchToPC::sendPosition(const int &x, const int &y)
{
	sender->SendPos(x, y);
}

void TouchToPC::sendButtonPress(const int &button, const int &press)
{
	sender->SendButton(button, press);
}

void TouchToPC::sendKeyPress(const QString &key)
{
	sender->SendKey(key);
}

void TouchToPC::send(const QString &val)
{
	sender->Send(val.toStdString());
}

QString TouchToPC::getIP()
{
	return getValueFor("IPAddress", "192.168.0.3");
}

void TouchToPC::setIP(const QString &IP)
{
	saveValueFor("IPAddress", QVariant(IP));
}

void TouchToPC::setPort(const QString &port)
{
	saveValueFor("PORT", QVariant(port));
}

QString TouchToPC::getPort()
{
	return getValueFor("PORT", "15000");
}

void TouchToPC::Setup()
{
	sender->Setup(getValueFor("IPAddress", "192.168.0.3"),
			getValueFor("PORT", "15000"), getValueFor("Password", ""));
}

QString TouchToPC::getValueFor(const QString &objectName,
		const QString &defaultValue)
{
	QSettings settings;

	if (settings.value(objectName).isNull())
	{
		return defaultValue;
	}

	return settings.value(objectName).toString();
}

bool TouchToPC::getBValueFor(const QString &objectName,
		const bool &defaultValue)
{
	QSettings settings;

	if (settings.value(objectName).isNull())
	{
		return defaultValue;
	}

	return settings.value(objectName).toBool();
}

void TouchToPC::saveValueFor(const QString &objectName,
		const QVariant &inputValue)
{
	QSettings settings;

	settings.setValue(objectName, inputValue);
}

void TouchToPC::setPassword(const QString &password)
{
	saveValueFor("Password", password);
}

QString TouchToPC::getPassword()
{
	return getValueFor("Password", "");
}

bool TouchToPC::checkTime(const int &oldTime, const QTime &newTime,
		const int &timeDifference)
{
	return oldTime < (newTime.msec() - timeDifference);
}

int TouchToPC::getTime(const QTime &time)
{
	return time.msec();
}
