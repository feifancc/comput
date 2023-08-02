import { ObjectId } from 'mongodb';
import mongoose from 'mongoose';

export interface UserModel {
  _id?: string;
  name?: string;
  code?: number
}
export const userModel = mongoose.model('User', new mongoose.Schema({
  name: String,
  code: Number,
}, { timestamps: true, }));




export interface ListDataModel {
  _id?: ObjectId;
  userOneId?: ObjectId;
  userOneName?: string;
  userTwoId?: ObjectId;
  userTwoName?: string;
}
export const listDataModel = mongoose.model('ListData', new mongoose.Schema({
  userOneId: ObjectId,
  userOneName: String,
  userTwoId: ObjectId,
  userTwoName: String,
}, { timestamps: true, }))



export enum ListMessageType {
  message,
  revoke,
}
export interface ListMessageModel {
  _id?: string;
  listDataId?: ObjectId;
  userId?: ObjectId;
  type?: number;
  userName?: string;
  content?: string;
}
export const listMessageModel = mongoose.model('listMessage', new mongoose.Schema({
  listDataId: {
    type: mongoose.Types.ObjectId,
    ref: 'listmessages'
  },
  userId: {
    type: ObjectId,
    ref: 'users'
  },
  type: {
    type: Number,
    default: ListMessageType.message
  },
  userName: String,
  content: String
}, { timestamps: true, }))
