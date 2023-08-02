import exporess from 'express'
import { addUser, deleteUser, getUser, isUser } from '../service/user';
import { err, info } from '../util';
import { addListData, deleteListData, getAllListData } from '../service/listData';
import { log } from 'console';
export const userRoute = exporess.Router();

userRoute.post('/addUser', async (req, res) => {
  const { name, code } = req.body
  const { feifan } = req.headers

  if (feifan !== 'feifan') return err(res, { msg: '????' }, { status: 401 });

  if (name && code) {
    const user = await getUser({ name })
    if (!user.length) {
      const users = await getUser({});
      const result = await addUser({ name, code })
      if (result) {
        await Promise.all(users.map(user => {
          return addListData({
            userOneId: result._id, userOneName: result.name,
            userTwoId: user._id, userTwoName: user.name
          })
        })).catch(() => err(res, { msg: "创建listData错误" }))
        return info(res, result)
      }
    } else {
      return err(res, { msg: 'name重复' })
    }
  }
  return err(res, { msg: '缺少必要参数' })
})

userRoute.post('/login', async (req, res) => {
  const { name, code } = req.body
  const [result] = await getUser({ name });
  if (result) {
    if (result.code == code) {
      info(res, result);
    } else {
      err(res, { msg: '密码错误' })
    }
  } else {
    err(res, { 'msg': '用户名错误', data: result })
  }
})


userRoute.delete('/user/delete/:userId', async (req, res) => {
  const { userId } = req.params
  const { feifan, code } = req.headers
  if (feifan != 'feifan' || code != '123456') return err(res, { msg: '拒绝访问' })
  if (! await isUser({ _id: userId })) return err(res, { 'msg': 'id不存在' })
  const listDatas = await getAllListData()
  const ids = listDatas.filter(listData => listData.userOneId == userId || listData.userTwoId == userId).map(user => user._id)
  try {
    const { deletedCount: deleteListCount } = await deleteListData({ _id: { '$in': ids } })
    const { deletedCount: deleteUserCount } = await deleteUser({ _id: { '$in': userId } })
    if (deleteListCount == 0 || deleteUserCount == 0) throw '123'
    return info(res, { msg: '删除成功' })
  } catch (e) {
    return err(res, { 'msg': '删除失败' })
  }
})
