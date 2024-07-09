/*
  Warnings:

  - You are about to drop the column `clientId` on the `Procedure` table. All the data in the column will be lost.
  - You are about to drop the column `images` on the `Procedure` table. All the data in the column will be lost.
  - You are about to drop the column `images` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Basket` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BasketLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProcedureLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProcedureTime` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_BasketLogToProcedureLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_BasketToProcedure` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `categoryId` to the `Procedure` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image` to the `Procedure` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "BasketLog" DROP CONSTRAINT "BasketLog_basketId_fkey";

-- DropForeignKey
ALTER TABLE "BasketLog" DROP CONSTRAINT "BasketLog_clientId_fkey";

-- DropForeignKey
ALTER TABLE "Procedure" DROP CONSTRAINT "Procedure_clientId_fkey";

-- DropForeignKey
ALTER TABLE "ProcedureLog" DROP CONSTRAINT "ProcedureLog_clientId_fkey";

-- DropForeignKey
ALTER TABLE "ProcedureLog" DROP CONSTRAINT "ProcedureLog_procedure_id_fkey";

-- DropForeignKey
ALTER TABLE "ProcedureTime" DROP CONSTRAINT "ProcedureTime_procedure_log_id_fkey";

-- DropForeignKey
ALTER TABLE "_BasketLogToProcedureLog" DROP CONSTRAINT "_BasketLogToProcedureLog_A_fkey";

-- DropForeignKey
ALTER TABLE "_BasketLogToProcedureLog" DROP CONSTRAINT "_BasketLogToProcedureLog_B_fkey";

-- DropForeignKey
ALTER TABLE "_BasketToProcedure" DROP CONSTRAINT "_BasketToProcedure_A_fkey";

-- DropForeignKey
ALTER TABLE "_BasketToProcedure" DROP CONSTRAINT "_BasketToProcedure_B_fkey";

-- AlterTable
ALTER TABLE "Procedure" DROP COLUMN "clientId",
DROP COLUMN "images",
ADD COLUMN     "categoryId" INTEGER NOT NULL,
ADD COLUMN     "image" TEXT NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "images",
ADD COLUMN     "roleId" INTEGER NOT NULL DEFAULT 1;

-- DropTable
DROP TABLE "Basket";

-- DropTable
DROP TABLE "BasketLog";

-- DropTable
DROP TABLE "ProcedureLog";

-- DropTable
DROP TABLE "ProcedureTime";

-- DropTable
DROP TABLE "_BasketLogToProcedureLog";

-- DropTable
DROP TABLE "_BasketToProcedure";

-- CreateTable
CREATE TABLE "UserRole" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "UserRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "phoneNumber" TEXT,
    "address" TEXT,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appointment" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "procedureId" INTEGER NOT NULL,
    "appointmentDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Appointment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserRole_name_key" ON "UserRole"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Procedure" ADD CONSTRAINT "Procedure_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "Procedure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
