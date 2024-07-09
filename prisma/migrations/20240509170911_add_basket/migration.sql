/*
  Warnings:

  - You are about to drop the `Complex` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ComplexLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ComplexLogToProcedureLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ComplexToProcedure` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ComplexLog" DROP CONSTRAINT "ComplexLog_clientId_fkey";

-- DropForeignKey
ALTER TABLE "ComplexLog" DROP CONSTRAINT "ComplexLog_complexId_fkey";

-- DropForeignKey
ALTER TABLE "_ComplexLogToProcedureLog" DROP CONSTRAINT "_ComplexLogToProcedureLog_A_fkey";

-- DropForeignKey
ALTER TABLE "_ComplexLogToProcedureLog" DROP CONSTRAINT "_ComplexLogToProcedureLog_B_fkey";

-- DropForeignKey
ALTER TABLE "_ComplexToProcedure" DROP CONSTRAINT "_ComplexToProcedure_A_fkey";

-- DropForeignKey
ALTER TABLE "_ComplexToProcedure" DROP CONSTRAINT "_ComplexToProcedure_B_fkey";

-- DropTable
DROP TABLE "Complex";

-- DropTable
DROP TABLE "ComplexLog";

-- DropTable
DROP TABLE "_ComplexLogToProcedureLog";

-- DropTable
DROP TABLE "_ComplexToProcedure";

-- CreateTable
CREATE TABLE "Basket" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT NOT NULL,

    CONSTRAINT "Basket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BasketLog" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "basketId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BasketLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_BasketToProcedure" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_BasketLogToProcedureLog" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_BasketToProcedure_AB_unique" ON "_BasketToProcedure"("A", "B");

-- CreateIndex
CREATE INDEX "_BasketToProcedure_B_index" ON "_BasketToProcedure"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_BasketLogToProcedureLog_AB_unique" ON "_BasketLogToProcedureLog"("A", "B");

-- CreateIndex
CREATE INDEX "_BasketLogToProcedureLog_B_index" ON "_BasketLogToProcedureLog"("B");

-- AddForeignKey
ALTER TABLE "BasketLog" ADD CONSTRAINT "BasketLog_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BasketLog" ADD CONSTRAINT "BasketLog_basketId_fkey" FOREIGN KEY ("basketId") REFERENCES "Basket"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BasketToProcedure" ADD CONSTRAINT "_BasketToProcedure_A_fkey" FOREIGN KEY ("A") REFERENCES "Basket"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BasketToProcedure" ADD CONSTRAINT "_BasketToProcedure_B_fkey" FOREIGN KEY ("B") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BasketLogToProcedureLog" ADD CONSTRAINT "_BasketLogToProcedureLog_A_fkey" FOREIGN KEY ("A") REFERENCES "BasketLog"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BasketLogToProcedureLog" ADD CONSTRAINT "_BasketLogToProcedureLog_B_fkey" FOREIGN KEY ("B") REFERENCES "ProcedureLog"("id") ON DELETE CASCADE ON UPDATE CASCADE;
