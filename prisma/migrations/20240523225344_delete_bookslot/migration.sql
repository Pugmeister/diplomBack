/*
  Warnings:

  - You are about to drop the `BookedSlot` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BookedSlot" DROP CONSTRAINT "BookedSlot_scheduleId_fkey";

-- DropTable
DROP TABLE "BookedSlot";
