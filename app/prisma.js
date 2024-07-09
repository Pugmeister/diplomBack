import { PrismaClient } from '@prisma/client';
import { hash } from 'argon2';

    const prisma = new PrismaClient();

    async function main() {
    try {
        const existingAdmin = await prisma.user.findFirst({
        where: { isAdmin: true },
        });
        if (existingAdmin) {
        console.log('Администратор уже существует в базе данных.');
        return;
        }

    await prisma.user.create({
    data: {
        email: 'admin@admin.com',
        name: 'Admin',
        phone: 'Admin',
        password: await hash('admin'), 
        isAdmin: true,
    },
    });

        console.log('Администратор успешно добавлен в базу данных.');
    } catch (error) {
        console.error('Ошибка при добавлении администратора:', error);
    } finally {
        await prisma.$disconnect();
    }
    }

    main()

    export default prisma