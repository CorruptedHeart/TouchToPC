/*
 * TouchSend.h
 *
 *  Created on: 01 Jul 2013
 *      Author: LordHeart
 */

#ifndef TOUCHSEND_H_
#define TOUCHSEND_H_

#include <bb/cascades/Application>

namespace topc
{

class ITouchSend
{
public:
	virtual void SendPos(const int &x, const int &y) = 0;
	virtual void SendButton(const int &button, const int &press) = 0;
	virtual void Setup(const QString &ip, const QString &port, const QString &password) = 0;
	virtual void SendPassword(const QString &password) = 0;
	virtual void SendKey(const QString &key) = 0;
	virtual void Send(const std::string &val) = 0;
	virtual ~ITouchSend() {}
};

} /* namespace topc */
#endif /* TOUCHSEND_H_ */
