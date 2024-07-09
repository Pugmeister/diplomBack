import asyncHandler from 'express-async-handler';
import prisma from '../prisma.js';

// @desc    Create new category
// @route   POST /categories
// @access  Private
export const createCategory = asyncHandler(async (req, res) => {
    const { name, description } = req.body;

const category = await prisma.category.create({
    data: {
        name,
        description,
    },
    });

res.status(201).json(category);
});

// @desc    Get all categories
// @route   GET /categories
// @access  Public
export const getCategories = asyncHandler(async (req, res) => {
    const categories = await prisma.category.findMany();

    res.json(categories);
});

// @desc    Get category by ID
// @route   GET /categories/:id
// @access  Public
export const getCategoryById = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const category = await prisma.category.findUnique({
    where: {
        id: parseInt(id),
    },
});

    if (!category) {
        res.status(404);
    throw new Error('Category not found');
    }

res.json(category);
});

// @desc    Update category
// @route   PUT /categories/:id
// @access  Private
export const updateCategory = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { name, description } = req.body;

    const updatedCategory = await prisma.category.update({
    where: {
        id: parseInt(id),
    },
    data: {
        name,
        description,
    },
    });

res.json(updatedCategory);
});

// @desc    Delete category
// @route   DELETE /categories/:id
// @access  Private
export const deleteCategory = asyncHandler(async (req, res) => {
    const { id } = req.params;

    await prisma.category.delete({
    where: {
        id: parseInt(id),
    },
});

    res.json({ message: 'Category removed' });
});
