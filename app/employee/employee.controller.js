import asyncHandler from 'express-async-handler';
import prisma from '../prisma.js';

export const getEmployees = asyncHandler(async (req, res) => {
    try {
        const employees = await prisma.employee.findMany();
        res.json(employees);
    } catch (error) {
        console.error("Failed to retrieve employees:", error);
        res.status(500).json({ error: error.message || "Internal Server Error" });
    }
});

export const createEmployee = asyncHandler(async (req, res) => {
    const { name, email, phone, photo } = req.body;

    const existingEmployee = await prisma.employee.findUnique({
        where: { email }
    });

    if (existingEmployee) {
        return res.status(400).json({ error: "Email already in use" });
    }

    try {
        const employee = await prisma.employee.create({
            data: { name, email, phone, photo }
        });
        res.status(201).json(employee);
    } catch (error) {
        console.error("Failed to create employee:", error);
        res.status(500).json({ error: error.message || "Internal Server Error" });
    }
});