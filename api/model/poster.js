import mongoose from "mongoose";

const posterSchema = new mongoose.Schema({
  posterName: {
    type: String,
    required: true,
    trim: true
  },
  imageUrl: {
    type: String,
    required: true
  }
}, {
  timestamps: true 
});

const Poster = mongoose.model('Poster', posterSchema);

export default Poster;
