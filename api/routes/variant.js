
import express from 'express';
import Variant from '../model/variant.js';
import Product from '../model/product.js';
import asyncHandler from 'express-async-handler';

const router = express.Router();

// Get all variants
router.get('/', asyncHandler(async (req, res) => {
    try {
        const variants = await Variant.find().populate('variantTypeId').sort({'variantTypeId': 1});
        res.status(200).json({ success: true, message: "Variants retrieved successfully.", data: variants });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Get a variant by ID
router.get('/:id', asyncHandler(async (req, res) => {
    try {
        const variantID = req.params.id;
        const variant = await Variant.findById(variantID).populate('variantTypeId');
        if (!variant) {
            return res.status(404).json({ success: false, message: "Variant not found." });
        }
        res.status(200).json({ success: true, message: "Variant retrieved successfully.", data: variant });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Create a new variant
router.post('/', asyncHandler(async (req, res) => {
    const { name, variantTypeId } = req.body;
    if (!name || !variantTypeId) {
        return res.status(400).json({ success: false, message: "Name and VariantType ID are required." });
    }

    try {
        const variant = new Variant({ name, variantTypeId });
        const newVariant = await variant.save();
        res.status(200).json({ success: true, message: "Variant created successfully.", data: newVariant});
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Update a variant
router.put('/:id', asyncHandler(async (req, res) => {
    const variantID = req.params.id;
    const { name, variantTypeId } = req.body;
    if (!name || !variantTypeId) {
        return res.status(400).json({ success: false, message: "Name and VariantType ID are required." });
    }

    try {
        const updatedVariant = await Variant.findByIdAndUpdate(variantID, { name, variantTypeId }, { new: true });
        if (!updatedVariant) {
            return res.status(404).json({ success: false, message: "Variant not found." });
        }
        res.status(200).json({ success: true, message: "Variant updated successfully.", data: updatedVariant });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Delete a variant
router.delete('/:id', asyncHandler(async (req, res) => {
    const variantID = req.params.id;
    try {
        // Check if any products reference this variant
        const products = await Product.find({ proVariantId: variantID });
        if (products.length > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete variant. Products are referencing it." });
        }

        // If no products are referencing the variant, proceed with deletion
        const variant = await Variant.findByIdAndDelete(variantID);
        if (!variant) {
            return res.status(404).json({ success: false, message: "Variant not found." });
        }
        res.status(200).json({ success: true, message: "Variant deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));


export default router;
