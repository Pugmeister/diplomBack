import asyncHandler from 'express-async-handler';
import prisma from '../../app/prisma.js';

// @desc    Create a new payment
// @route   POST /payments
// @access  Private
export const createPayment = asyncHandler(async (req, res) => {
    const { userId, amount, appointmentId } = req.body;

const payment = await prisma.payment.create({
    data: {
        userId,
        amount,
        appointmentId,
    },
});

res.status(201).json(payment);
});

// @desc    Get payment by ID
// @route   GET /payments/:id
// @access  Public
export const getPaymentById = asyncHandler(async (req, res) => {
    const { id } = req.params;

const payment = await prisma.payment.findUnique({
    where: {
        id: parseInt(id),
    },
});

if (!payment) {
    res.status(404);
    throw new Error('Payment not found');
}

res.json(payment);
});

// @desc    Get all payments
// @route   GET /api/payments
// @access  Public
export const getPayments = asyncHandler(async (req, res) => {
const payments = await prisma.payment.findMany();

res.json(payments);
});

// @desc    Update payment by ID
// @route   PUT /api/payments/:id
// @access  Private
export const updatePayment = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { userId, amount, appointmentId } = req.body;

    const updatedPayment = await prisma.payment.update({
    where: {
        id: parseInt(id),
    },
    data: {
        userId,
        amount,
        appointmentId,
    },
    });

    res.json(updatedPayment);
});

  // @desc    Delete payment by ID
  // @route   DELETE /api/payments/:id
  // @access  Private
export const deletePayment = asyncHandler(async (req, res) => {
    const { id } = req.params;

    await prisma.payment.delete({
    where: {
        id: parseInt(id),
    },
    });

res.json({ message: 'Payment deleted successfully' });
});
