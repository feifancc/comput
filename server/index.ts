import express from 'express'
import { userRoute } from './router/user';
import { listDataRoute } from './router/listData';
import { listMessageRoute } from './router/listMessage';
import bodyParser from 'body-parser';
import './mongodb/index'
import './soket'

const app = express();
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: false }))
app.use('/api', userRoute);
app.use('/api', listDataRoute);
app.use('/api', listMessageRoute);

app.listen(80, () => console.log('ok'))