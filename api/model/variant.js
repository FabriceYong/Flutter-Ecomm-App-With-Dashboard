import mongoose  from "mongoose";

const variantSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    variantTypeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'VariantType',
        required: true
    }
},{ timestamps: true });

export default mongoose.model('Variant', variantSchema);
