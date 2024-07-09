/*
  Warnings:

  - You are about to drop the column `cost` on the `Complex` table. All the data in the column will be lost.
  - Added the required column `cost` to the `Procedure` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Complex" DROP COLUMN "cost";

-- AlterTable
ALTER TABLE "Procedure" ADD COLUMN     "cost" INTEGER NOT NULL;
