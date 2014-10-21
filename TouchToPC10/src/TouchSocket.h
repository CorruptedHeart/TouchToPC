/*
 * PcTouch.h
 *
 *  Created on: 02 Jun 2013
 *      Author: LordHeart
 */

#ifndef TOUCHSOCKET_H_
#define TOUCHSOCKET_H_
#include "ITouchSend.h"
#include <netdb.h>
#include <sstream>

namespace topc
{

class TouchSocket: public ITouchSend
{
public:
	TouchSocket();
	virtual void SendPos(const int &x, const int &y);
	virtual void SendButton(const int &button, const int &press);
	virtual void Setup(const QString &ip, const QString &port, const QString &password);
	virtual void SendPassword(const QString &password);
	virtual void SendKey(const QString &key);
	virtual void Send(const std::string &val);
	virtual ~TouchSocket();

private:
	int mSocket;
	struct addrinfo host_info;
	struct addrinfo *host_info_list;
	int status;
	std::stringstream builderString;
};

} /* namespace topc */
#endif /* TOUCHSOCKET_H_ */
