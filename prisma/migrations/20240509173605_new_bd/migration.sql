/*
  Warnings:

  - You are about to drop the column `categoryId` on the `Procedure` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `Procedure` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Procedure` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Procedure` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Procedure` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Integer`.
  - You are about to drop the column `roleId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Appointment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserRole` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `clientId` to the `Procedure` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_procedureId_fkey";

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_userId_fkey";

-- DropForeignKey
ALTER TABLE "Procedure" DROP CONSTRAINT "Procedure_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_userId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_roleId_fkey";

-- AlterTable
ALTER TABLE "Procedure" DROP COLUMN "categoryId",
DROP COLUMN "description",
DROP COLUMN "image",
DROP COLUMN "name",
ADD COLUMN     "clientId" INTEGER NOT NULL,
ADD COLUMN     "images" TEXT[],
ALTER COLUMN "price" SET DATA TYPE INTEGER;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "roleId",
ADD COLUMN     "images" TEXT[];

-- DropTable
DROP TABLE "Appointment";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Profile";

-- DropTable
DROP TABLE "UserRole";

-- CreateTable
CREATE TABLE "Complex" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT NOT NULL,

    CONSTRAINT "Complex_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProcedureTime" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "weight" INTEGER NOT NULL DEFAULT 0,
    "repeat" INTEGER NOT NULL DEFAULT 0,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "procedure_log_id" INTEGER,

    CONSTRAINT "ProcedureTime_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProcedureLog" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "procedure_id" INTEGER,

    CONSTRAINT "ProcedureLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComplexLog" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "complexId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ComplexLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ComplexToProcedure" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ComplexLogToProcedureLog" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ComplexToProcedure_AB_unique" ON "_ComplexToProcedure"("A", "B");

-- CreateIndex
CREATE INDEX "_ComplexToProcedure_B_index" ON "_ComplexToProcedure"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ComplexLogToProcedureLog_AB_unique" ON "_ComplexLogToProcedureLog"("A", "B");

-- CreateIndex
CREATE INDEX "_ComplexLogToProcedureLog_B_index" ON "_ComplexLogToProcedureLog"("B");

-- AddForeignKey
ALTER TABLE "Procedure" ADD CONSTRAINT "Procedure_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProcedureTime" ADD CONSTRAINT "ProcedureTime_procedure_log_id_fkey" FOREIGN KEY ("procedure_log_id") REFERENCES "ProcedureLog"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProcedureLog" ADD CONSTRAINT "ProcedureLog_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProcedureLog" ADD CONSTRAINT "ProcedureLog_procedure_id_fkey" FOREIGN KEY ("procedure_id") REFERENCES "Procedure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComplexLog" ADD CONSTRAINT "ComplexLog_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComplexLog" ADD CONSTRAINT "ComplexLog_complexId_fkey" FOREIGN KEY ("complexId") REFERENCES "Complex"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ComplexToProcedure" ADD CONSTRAINT "_ComplexToProcedure_A_fkey" FOREIGN KEY ("A") REFERENCES "Complex"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ComplexToProcedure" ADD CONSTRAINT "_ComplexToProcedure_B_fkey" FOREIGN KEY ("B") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ComplexLogToProcedureLog" ADD CONSTRAINT "_ComplexLogToProcedureLog_A_fkey" FOREIGN KEY ("A") REFERENCES "ComplexLog"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ComplexLogToProcedureLog" ADD CONSTRAINT "_ComplexLogToProcedureLog_B_fkey" FOREIGN KEY ("B") REFERENCES "ProcedureLog"("id") ON DELETE CASCADE ON UPDATE CASCADE;
