/*
  Warnings:

  - You are about to drop the column `user_id` on the `UserPrefrence` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_prefrence_id]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id_fk]` on the table `UserPrefrence` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id_fk` to the `UserPrefrence` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "UserPrefrence" DROP CONSTRAINT "UserPrefrence_user_id_fkey";

-- DropIndex
DROP INDEX "UserPrefrence_user_id_key";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "user_prefrence_id" INTEGER;

-- AlterTable
ALTER TABLE "UserPrefrence" DROP COLUMN "user_id",
ADD COLUMN     "user_id_fk" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "User_user_prefrence_id_key" ON "User"("user_prefrence_id");

-- CreateIndex
CREATE UNIQUE INDEX "UserPrefrence_user_id_fk_key" ON "UserPrefrence"("user_id_fk");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_user_prefrence_id_fkey" FOREIGN KEY ("user_prefrence_id") REFERENCES "UserPrefrence"("id") ON DELETE SET NULL ON UPDATE CASCADE;
