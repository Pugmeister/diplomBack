/*
  Warnings:

  - A unique constraint covering the columns `[reviewId]` on the table `Appointment` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_appointmentId_fkey";

-- AlterTable
ALTER TABLE "Appointment" ADD COLUMN     "reviewId" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Appointment_reviewId_key" ON "Appointment"("reviewId");

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES "Review"("id") ON DELETE SET NULL ON UPDATE CASCADE;
