/*
  Warnings:

  - You are about to drop the `Beaty` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Fitness` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Medicene` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Spa` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_BeatyToProcedure` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FitnessToProcedure` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_MediceneToProcedure` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ProcedureToSpa` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ProcedureToUser` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `clientId` to the `Procedure` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_BeatyToProcedure" DROP CONSTRAINT "_BeatyToProcedure_A_fkey";

-- DropForeignKey
ALTER TABLE "_BeatyToProcedure" DROP CONSTRAINT "_BeatyToProcedure_B_fkey";

-- DropForeignKey
ALTER TABLE "_FitnessToProcedure" DROP CONSTRAINT "_FitnessToProcedure_A_fkey";

-- DropForeignKey
ALTER TABLE "_FitnessToProcedure" DROP CONSTRAINT "_FitnessToProcedure_B_fkey";

-- DropForeignKey
ALTER TABLE "_MediceneToProcedure" DROP CONSTRAINT "_MediceneToProcedure_A_fkey";

-- DropForeignKey
ALTER TABLE "_MediceneToProcedure" DROP CONSTRAINT "_MediceneToProcedure_B_fkey";

-- DropForeignKey
ALTER TABLE "_ProcedureToSpa" DROP CONSTRAINT "_ProcedureToSpa_A_fkey";

-- DropForeignKey
ALTER TABLE "_ProcedureToSpa" DROP CONSTRAINT "_ProcedureToSpa_B_fkey";

-- DropForeignKey
ALTER TABLE "_ProcedureToUser" DROP CONSTRAINT "_ProcedureToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_ProcedureToUser" DROP CONSTRAINT "_ProcedureToUser_B_fkey";

-- AlterTable
ALTER TABLE "Procedure" ADD COLUMN     "clientId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "Beaty";

-- DropTable
DROP TABLE "Fitness";

-- DropTable
DROP TABLE "Medicene";

-- DropTable
DROP TABLE "Spa";

-- DropTable
DROP TABLE "_BeatyToProcedure";

-- DropTable
DROP TABLE "_FitnessToProcedure";

-- DropTable
DROP TABLE "_MediceneToProcedure";

-- DropTable
DROP TABLE "_ProcedureToSpa";

-- DropTable
DROP TABLE "_ProcedureToUser";

-- CreateTable
CREATE TABLE "Complex" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT NOT NULL,
    "cost" INTEGER NOT NULL,
    "kolvo" INTEGER NOT NULL,

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
