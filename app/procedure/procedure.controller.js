import asyncHandler from 'express-async-handler';
import prisma from '../prisma.js';

// @desc    Create new procedure
// @route   POST /api/procedures
// @access  Private
export const createProcedure = asyncHandler(async (req, res) => {
const { name, description, price, image, categoryId } = req.body;

const procedure = await prisma.procedure.create({
    data: {
		name,
		description,
		price,
		image,
		categoryId,
    }
});

res.status(201).json(procedure);
});

// @desc    Get procedure
// @route   GET /api/procedures
// @access  Public
export const getProcedures = asyncHandler(async (req, res) => {
const procedures = await prisma.procedure.findMany();

res.json(procedures);
});

// @desc    Get info procedure
// @route   GET /api/procedures/:id
// @access  Public
export const getProcedureById = asyncHandler(async (req, res) => {
const { id } = req.params;

const procedure = await prisma.procedure.findUnique({
    where: {
    id: parseInt(id)
    }
});

if (!procedure) {
    res.status(404);
    throw new Error('Процедура не найдена');
}

res.json(procedure);
});

export const updateProcedure = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { name, description, price, image, categoryId } = req.body;

    const updatedProcedure = await prisma.procedure.update({
        where: {
            id: parseInt(id)
        },
        data: {
            name,
            description,
            price,
            image,
            categoryId
        }
    });

    res.json(updatedProcedure);
});

// @desc    Delete procedure by ID
// @route   DELETE /api/procedures/:id
// @access  Private
export const deleteProcedure = asyncHandler(async (req, res) => {
    const { id } = req.params;

    await prisma.procedure.delete({
        where: {
            id: parseInt(id)
        }
    });

    res.json({ message: 'Процедура успешно удалена' });
});