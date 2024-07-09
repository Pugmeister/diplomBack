import asyncHandler from 'express-async-handler';
import { PrismaClient } from '@prisma/client';
import { startOfDay, endOfDay } from 'date-fns';

const prisma = new PrismaClient();

export const getSchedulesByEmployee = asyncHandler(async (req, res) => {
    const { employeeId } = req.params;
    const { date } = req.query;

    if (!date) {
        return res.status(400).json({ error: 'Missing required date' });
    }

    try {
        const parsedDate = new Date(date);
        if (isNaN(parsedDate)) {
            return res.status(400).json({ error: 'Invalid date format' });
        }

        const startOfDayDate = startOfDay(parsedDate);
        const endOfDayDate = endOfDay(parsedDate);

        const schedules = await prisma.schedule.findMany({
            where: {
                employeeId: parseInt(employeeId),
                startTime: {
                    gte: startOfDayDate,
                    lte: endOfDayDate,
                }
            },
            orderBy: {
                startTime: 'asc'
            }
        });

        res.json(schedules);
    } catch (error) {
        console.error("Не удалось загрузить расписания:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});

export const getAllSchedulesByEmployee = asyncHandler(async (req, res) => {
    const { employeeId } = req.params;

    try {
        const schedules = await prisma.schedule.findMany({
            where: {
                employeeId: parseInt(employeeId),
            },
            orderBy: {
                startTime: 'asc'
            }
        });

        res.json(schedules);
    } catch (error) {
        console.error("Не удалось загрузить все расписания:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});

export const createSchedule = asyncHandler(async (req, res) => {
    const { employeeId, startTime } = req.body;

    if (!employeeId || !startTime) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    try {
        const schedule = await prisma.schedule.create({
            data: {
                //id: Math.floor(Math.random() * 99999),
                employeeId: parseInt(employeeId),
                startTime: new Date(startTime),
                isBooked: false
            }
        });
        res.status(201).json(schedule);
    } catch (error) {
        console.error("Failed to create schedule:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});

export const updateSchedule = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const schedule = req.body;

    if (!schedule || !Array.isArray(schedule) || schedule.length === 0) {
        return res.status(400).json({ error: 'Missing or invalid schedule data' });
    }

    try {
        const updatedSchedules = await Promise.all(schedule.map(async (slot) => {
            if (!slot.id || !slot.startTime) {
                throw new Error('Missing required fields in schedule slot');
            }

            return await prisma.schedule.update({
                where: { id: parseInt(slot.id) },
                data: {
                    startTime: new Date(slot.startTime),
                    isBooked: slot.isBooked || false
                }
            });
        }));

        res.status(200).json(updatedSchedules);
    } catch (error) {
        console.error("Failed to update schedule:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});

export const deleteSchedule = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const existingSchedule = await prisma.schedule.findUnique({
            where: { id: parseInt(id) }
        });

        if (!existingSchedule) {
            return res.status(404).json({ error: 'Schedule not found' });
        }

        await prisma.schedule.delete({
            where: { id: parseInt(id) }
        });
        res.status(204).json({ message: 'Schedule deleted successfully' });
    } catch (error) {
        console.error("Failed to delete schedule:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});

export const deleteDaySchedule = asyncHandler(async (req, res) => {
    const { employeeId } = req.params;
    const { date } = req.query;

    if (!date) {
        return res.status(400).json({ error: 'Missing required date' });
    }

    try {
        const parsedDate = new Date(date);
        if (isNaN(parsedDate)) {
            return res.status(400).json({ error: 'Invalid date format' });
        }

        const startOfDayDate = startOfDay(parsedDate);
        const endOfDayDate = endOfDay(parsedDate);

        const schedules = await prisma.schedule.findMany({
            where: {
                employeeId: parseInt(employeeId),
                startTime: {
                    gte: startOfDayDate,
                    lte: endOfDayDate,
                }
            }
        });

        if (schedules.length === 0) {
            return res.status(404).json({ message: 'No schedules found for the specified date' });
        }

        const deletedCount = await prisma.schedule.deleteMany({
            where: {
                employeeId: parseInt(employeeId),
                startTime: {
                    gte: startOfDayDate,
                    lte: endOfDayDate,
                }
            }
        });

        res.status(200).json({ message: `Deleted ${deletedCount.count} schedules successfully` });
    } catch (error) {
        console.error("Failed to delete schedule:", error);
        res.status(500).json({ error: error.message || 'Internal server error' });
    }
});




export const bookScheduleSlot = asyncHandler(async (req, res) => {
    const { scheduleId } = req.body;

    if (!scheduleId) {
        return res.status(400).json({ error: 'Missing scheduleId' });
    }

    try {
        const schedule = await prisma.schedule.update({
            where: { id: parseInt(scheduleId) },
            data: { isBooked: true },
        });
        res.status(200).json(schedule);
    } catch (error) {
        console.error("Failed to book schedule slot:", error);
        res.status(500).json({ error: error.message || 'Internal Server Error' });
    }
});
