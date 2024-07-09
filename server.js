import 'colors';
import express from 'express';
import authRoutes from './app/auth/auth.routes.js';
import userRoutes from './app/user/user.routes.js';
import appointmentRoutes from './app/appointment/appointment.routes.js';
import procedureRoutes from './app/procedure/procedure.routes.js';
import paymentRoutes from './app/payment/payment.routes.js';
import categoryRoutes from './app/category/category.routes.js';
import reviewRoutes from './app/review/review.routes.js';
import employeeRoutes from './app/employee/employee.routes.js';
import scheduleRoutes from './app/schedule/schedule.routes.js';
import { notFound, errorHandler } from './app/middleware/error.middleware.js';
import dotenv from 'dotenv';
import morgan from 'morgan';
import prisma from './app/prisma.js';
import cors from 'cors';

dotenv.config();

const app = express();

async function main() {
    if (process.env.NODE_ENV == 'development') app.use(morgan('dev'))

    app.use(cors());
    app.use(express.json());

    app.use(authRoutes);
    app.use(userRoutes);
    app.use( procedureRoutes);
    app.use( appointmentRoutes);
    app.use( paymentRoutes);
    app.use( categoryRoutes);
    app.use( reviewRoutes);
    app.use( employeeRoutes);
    app.use( scheduleRoutes);
    
    app.use(notFound);
    app.use(errorHandler);

    const PORT = process.env.PORT || 5173; 
    app.listen(PORT, () => {
        console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`.magenta.bold);
    });
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async e => {
        console.error(e);
        await prisma.$disconnect();
        process.exit(1);
    });
