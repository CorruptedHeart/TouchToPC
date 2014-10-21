/*
 * PcTouch.cpp
 *
 *  Created on: 02 Jun 2013
 *      Author: LordHeart
 */

#include "TouchSocket.h"
#include <cstring>
#include <sys/socket.h>

namespace topc
{

TouchSocket::TouchSocket()
{
	memset(&host_info, 0, sizeof(host_info));
	host_info.ai_family = AF_INET;
	host_info.ai_socktype = SOCK_DGRAM;
	status = 0;
	mSocket = -1;
	memset(&host_info_list, 0, sizeof(host_info_list));
}

TouchSocket::~TouchSocket()
{
}

void TouchSocket::Setup(const QString &ip, const QString &port, const QString &password)
{
	status = getaddrinfo(ip.toUtf8().constData(), port.toUtf8().constData(), &host_info, &host_info_list);

	mSocket = socket(host_info_list->ai_family, host_info_list->ai_socktype,
			host_info_list->ai_protocol);

	if (status != 0)
	{
		qDebug("getaddrinfo error");
		qDebug(gai_strerror(status));
	}

	if (mSocket == -1)
		qDebug("socket error");

	status = connect(mSocket, host_info_list->ai_addr,
			host_info_list->ai_addrlen);

	if (status == -1)
		qDebug("connect error");

	freeaddrinfo(host_info_list);

	SendPassword(password);
}

void TouchSocket::SendPos(const int &x, const int &y)
{
	builderString.str("X:");
	builderString << "X:";
	builderString << x;
	builderString << "Y:";
	builderString << y;
	Send(builderString.str());
}

void TouchSocket::SendButton(const int &button, const int &press)
{
	builderString.str("");
	builderString << button;
	builderString << press;
	Send(builderString.str());
}

void TouchSocket::SendKey(const QString &key)
{
	builderString.str("K:");
	builderString << "K:" << key.toStdString();
	Send(builderString.str());
}

void TouchSocket::SendPassword(const QString &password)
{
	builderString.str("P:");
	builderString << "P:" << password.toStdString();
	Send(builderString.str());
}

void TouchSocket::Send(const std::string &val)
{
	const char* msg = val.c_str();
	int len;
	len = strlen(msg);
	send(mSocket, msg, len, 0);
}

}
