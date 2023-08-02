import express from 'express'
import { err, info } from '../util';
import { getUserById } from '../service/user';
import { addListMessage, getListMessageByListDataId, revokeMessage } from '../service/listMessage';
import { getListData } from '../service/listData';

export const listMessageRoute = express.Router();

listMessageRoute.post('/addMessage', async (req, res) => {
  const { userId, listDataId, content, type } = req.body
  if (userId && listDataId && content) {
    try {
      const resUser = await getUserById(userId);
      const [resListData] = await getListData({ _id: listDataId });
      if (resUser && resListData) {
        const result = await addListMessage({
          userId: resUser._id, userName: resUser.name,
          listDataId: resListData._id, content, type: type ?? 0
        })
        return info(res, result);
      } else {
        return err(res, { msg: 'id错误' })
      }
    } catch (e) {
      return err(res, { msg: '查询出错' })
    }
  } else {
    return err(res, { msg: '传值错误' })
  }
})

listMessageRoute.get('/message/revoke/:messageId/:listDataId', async (req, res) => {
  const { messageId, listDataId } = req.params
  const { type } = req.query
  if (messageId && listDataId && type) {
    const result = await revokeMessage(listDataId, messageId, +type);
    if (result.modifiedCount != 0) {
      return info(res, result)
    }
    return err(res, { msg: '更新失败' })
  }
  return err(res, { msg: '缺少必要参数' })
})

listMessageRoute.get('/getListMessage/:listDataId', async (req, res) => {
  const { listDataId } = req.params
  if (listDataId) {
    const result = await getListMessageByListDataId(listDataId)
    info(res, result)
  } else {
    return err(res)
  }
})


