import express from 'express'
import { err, info } from '../util';
import { getUserById } from '../service/user';
import { addListData, getAllListData } from '../service/listData';

export const listDataRoute = express.Router();

listDataRoute.post('/addListData', async (req, res) => {
  const { userIdOne, userIdTwo } = req.body
  if (userIdOne && userIdTwo) {
    try {
      const userOne = await getUserById(userIdOne);
      const userTow = await getUserById(userIdTwo);
      if (userTow && userOne) {
        const result = await addListData({
          userOneId: userOne._id, userOneName: userOne.name,
          userTwoId: userTow._id, userTwoName: userTow.name
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

listDataRoute.post('/getListData/diff', async (req, res) => {
  const { userid } = req.headers
  const { content } = req.body
  if (userid) {
    const result = await getAllListData();
    const data = result.filter(e => e.userOneId.toString() == userid || e.userTwoId.toString() == userid)
    return info(res, diff(data, JSON.parse(content)))
  } else {
    return err(res)
  }
})

listDataRoute.get('/getListData/:userId', async (req, res) => {
  const { userId } = req.params
  if (userId) {
    const result = await getAllListData();
    return info(res, result.filter(e => e.userOneId.toString() == userId || e.userTwoId.toString() == userId))
  } else {
    return err(res)
  }
})

listDataRoute.get('/getListData/:userId/:listDataId', async (req, res) => {
  const { userId, listDataId } = req.params
  if (userId) {
    const result = await getAllListData();
    return info(res, result.filter(e => (e.userOneId.toString() == userId || e.userTwoId.toString() == userId) && e._id == listDataId))
  } else {
    return err(res)
  }
})


// 对比新旧消息
function diff(data: any, content: any) {
  let isRender = false;
  const changeds = data.map((e: any, i: number) => {
    const changed = (e?.listMessage?.length || 0) - (content[i]?.listMessageDiff?.length || 0)

    const old = content[i]?.listMessageDiff
    const messageDetailDiffResult = e?.listMessage.map((e: any, i: number) => ({ new: { id: e?._id, type: e.type, content: e.content }, old: { id: old[i]?.id, type: old[i]?.type, content: old[i]?.content } }))
    const messageLengthDiff = (e?.listMessage?.length != content[i]?.listMessageDiff?.length)
    const messageDetailDiff = (!e?.listMessage?.every((msg: any, index: number) => msg.type == content[i]?.listMessageDiff[index]?.type && msg.content == content[i]?.listMessageDiff[index]?.content))

    if (messageLengthDiff || changed > 0 || messageDetailDiff) {
      isRender = true;
    }
    e.changed = changed;
    return {
      listId: e._id,
      changed
    }
  })
  const res = {
    isRender,
    changeds,
    data: isRender ? data : null
  }

  return res
}