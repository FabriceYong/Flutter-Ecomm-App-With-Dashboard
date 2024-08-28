

import express from 'express';
import VariantType from '../model/variantType.js';
import Product from '../model/product.js';
import Variant from '../model/variant.js';
import asyncHandler from 'express-async-handler';

const router = express.Router();

// Get all variant types
router.get('/', asyncHandler(async (req, res) => {
    try {
        const variantTypes = await VariantType.find();
        res.status(200).json({ success: true, message: "VariantTypes retrieved successfully.", data: variantTypes });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Get a variant type by ID
router.get('/:id', asyncHandler(async (req, res) => {
    try {
        const variantTypeID = req.params.id;
        const variantType = await VariantType.findById(variantTypeID);
        if (!variantType) {
            return res.status(404).json({ success: false, message: "VariantType not found." });
        }
        res.status(200).json({ success: true, message: "VariantType retrieved successfully.", data: variantType });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Create a new variant type
router.post('/', asyncHandler(async (req, res) => {
    const { name ,type } = req.body;
    if (!name || !type) {
        return res.status(400).json({ success: false, message: "Name and Type are required." });
    }

    try {
        const variantType = new VariantType({ name , type });
        const newVariantType = await variantType.save();
        res.status(200).json({ success: true, message: "VariantType created successfully.", data: newVariantType });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Update a variant type
router.put('/:id', asyncHandler(async (req, res) => {
    const variantTypeID = req.params.id;
    const { name ,type } = req.body;
    if (!name) {
        return res.status(400).json({ success: false, message: "Name is required." });
    }

    try {
        const updatedVariantType = await VariantType.findByIdAndUpdate(variantTypeID, { name , type}, { new: true });
        if (!updatedVariantType) {
            return res.status(404).json({ success: false, message: "VariantType not found." });
        }
        res.status(200).json({ success: true, message: "VariantType updated successfully.", data: updatedVariantType });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

// Delete a variant type
router.delete('/:id', asyncHandler(async (req, res) => {
    const variantTypeID = req.params.id;
    try {
        // Check if any variant is associated with this variant type
        const variantCount = await Variant.countDocuments({ variantTypeId: variantTypeID });
        if (variantCount > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete variant type. It is associated with one or more variants." });
        }
        
        // Check if any products reference this variant type
        const products = await Product.find({ proVariantTypeId: variantTypeID });
        if (products.length > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete variant type. Products are referencing it." });
        }

        // If no variants or products are associated, proceed with deletion of the variant type
        const variantType = await VariantType.findByIdAndDelete(variantTypeID);
        if (!variantType) {
            return res.status(404).json({ success: false, message: "Variant type not found." });
        }
        res.status(200).json({ success: true, message: "Variant type deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));



export default router;
