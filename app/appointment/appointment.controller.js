import asyncHandler from 'express-async-handler';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// @desc    Create a new appointment
// @route   POST /appointment
// @access  Private
export const createAppointment = asyncHandler(async (req, res) => {
    const { userId, procedureId, employeeId, date } = req.body;

    try {
        const appointment = await prisma.appointment.create({
            data: {
                date: new Date(date),
                user: {
                    connect: { id: parseInt(userId) }
                },
                procedure: {
                    connect: { id: parseInt(procedureId) }
                },
                employee: { 
                    connect: { id: parseInt(employeeId) }
                },
            }
        });

        res.status(201).json(appointment);
    } catch (error) {
        console.error("Failed to create appointment:", error);
        res.status(500).json({ error: error.message || "Internal server error" });
    }
});

// @desc    Get all appointments
// @route   GET /appointment
// @access  Public
export const getAppointments = asyncHandler(async (req, res) => {
    try {
        const appointments = await prisma.appointment.findMany({
            include: {
                user: true,
                procedure: true,
                employee: true,
            },
        });
        res.json(appointments);
    } catch (error) {
        console.error("Failed to fetch appointments:", error);
        res.status(500).json({ error: error.message || "Internal server error" });
    }
});

// @desc    Get appointment by ID
// @route   GET /appointment/:id
// @access  Public
export const getAppointmentById = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const appointment = await prisma.appointment.findUnique({
            where: {
                id: parseInt(id),
            },
            include: {
                user: true,
                procedure: true,
                employee: true,
            },
        });

        if (!appointment) {
            res.status(404);
            throw new Error('Appointment not found');
        }

        res.json(appointment);
    } catch (error) {
        console.error("Failed to fetch appointment:", error);
        res.status(500).json({ error: error.message || "Internal server error" });
    }
});

// @desc    Update an appointment
// @route   PUT /appointment/:id
// @access  Private
export const updateAppointment = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { userId, procedureId, employeeId, date } = req.body;

    try {
        const appointment = await prisma.appointment.update({
            where: {
                id: parseInt(id),
            },
            data: {
                userId,
                procedureId,
                employeeId,
                date: new Date(date),
            },
        });

        res.json(appointment);
    } catch (error) {
        console.error("Failed to update appointment:", error);
        res.status500().json({ error: error.message || "Internal server error" });
    }
});

// @desc    Delete an appointment
// @route   DELETE /appointment/:id
// @access  Private
export const deleteAppointment = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        await prisma.appointment.delete({
            where: {
                id: parseInt(id),
            },
        });

        res.json({ message: 'Appointment deleted successfully' });
    } catch (error) {
        console.error("Failed to delete appointment:", error);
        res.status(500).json({ error: error.message || "Internal server error" });
    }
});