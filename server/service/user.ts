import { UserModel, userModel } from "../mongodb/model"

export const addUser = async (data: UserModel) => {
  const res = await userModel.create(data)
  return res
}

export const getUserById = async (id: any) => {
  const res = await userModel.findById(id)
  return res
}


export const getUser = async (data: any) => {
  const res = await userModel.find(data)
  return res
}

export const deleteUser = async (data: any) => {
  return await userModel.deleteOne(data)
}

export const isUser = async (data: UserModel) => {
  const result = await getUser(data);
  return result.length != 0;
}