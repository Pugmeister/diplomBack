import asyncHandler from 'express-async-handler';
import prisma from '../../prisma.js';

// @desc    Create new appointment log
// @route   POST /appointment-logs
// @access  Private
export const createAppointmentLog = asyncHandler(async (req, res) => {
const { appointmentId, procedureId, paymentId } = req.body;

const appointmentLog = await prisma.appointmentLog.create({
    data: {
        appointmentId,
        procedureId,
        paymentId,
    },
});

res.status(201).json(appointmentLog);
});

// @desc    Get appointment log by ID
// @route   GET /appointment-logs/:id
// @access  Public
export const getAppointmentLogById = asyncHandler(async (req, res) => {
const { id } = req.params;

const appointmentLog = await prisma.appointmentLog.findUnique({
    where: {
        id: parseInt(id),
    },
});

if (!appointmentLog) {
    res.status(404);
    throw new Error('Appointment Log not found');
}

res.json(appointmentLog);
});


// @desc    Complete appointment log
// @route   PUT /appointment-logs/:id/complete
// @access  Private
export const completeAppointmentLog = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const appointmentLog = await prisma.appointmentLog.update({
        where: { id: parseInt(id) },
        data: { completed: true },
    });

    if (!appointmentLog) {
        res.status(404);
        throw new Error('Appointment Log not found');
    }

    res.json(appointmentLog);
});