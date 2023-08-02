import { ObjectId } from "mongodb";
import { ListMessageModel, listDataModel, listMessageModel } from "../mongodb/model";

export const getListMessageByListDataId = async (id: string | ObjectId) => {
  return await listMessageModel.find({ listDataId: id })
}

export const addListMessage = async (data: ListMessageModel) => {
  return await listMessageModel.create(data);
}

export const revokeMessage = async (listDataId: string, messageId: string, type: number) => {
  return await listMessageModel.updateOne({ listDataId, _id: messageId }, { type })
}