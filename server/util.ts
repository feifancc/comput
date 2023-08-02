import { Response } from 'express'

export const info = (res: Response, data?: any) => res.send({ code: 1000, msg: 'ok', data: data || null })
export const err = (res: Response, data?: { data?: any, msg?: string }, config?: { status?: number }) => res.status(config?.status || 200).send({ code: 0, msg: data?.msg || 'err', data: data?.data || null })
