import { ObjectId } from "mongodb"
import { ListDataModel, listDataModel } from "../mongodb/model"

export const addListData = async (data: ListDataModel) => {
  return await listDataModel.create(data)
}

export const getAllListData = async () => {
  return await listDataModel.aggregate([{
    $lookup: {
      from: 'listmessages',
      localField: '_id',
      foreignField: 'listDataId',
      as: 'listMessage'
    }
  }])
}


export const getListData = async (data: ListDataModel) => {
  return await listDataModel.find(data)
}

export const deleteListData = async (datas: any) => {
  return await listDataModel.deleteMany(datas)
}