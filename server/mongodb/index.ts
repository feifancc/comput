import mongoose from 'mongoose';
import './model'

const mongodbUrl = 'mongodb://127.0.0.1:27017/time'
mongoose.connect(mongodbUrl);
mongoose.connection.once('open', () => console.log('connect'))

