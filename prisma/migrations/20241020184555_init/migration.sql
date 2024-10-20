/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[uuid]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ThemeEnum" AS ENUM ('DARK', 'LIGHT');

-- CreateEnum
CREATE TYPE "LanguageEnum" AS ENUM ('AR', 'EN');

-- AlterTable
ALTER TABLE "User" DROP COLUMN "name",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "date_of_birth" TIMESTAMP(3),
ADD COLUMN     "full_name" TEXT,
ADD COLUMN     "last_login" TIMESTAMP(3),
ADD COLUMN     "password" TEXT NOT NULL,
ADD COLUMN     "refresh_tokens" TEXT[],
ADD COLUMN     "roles" INTEGER[] DEFAULT ARRAY[1]::INTEGER[],
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "username" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "UserPrefrence" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "theme" "ThemeEnum" NOT NULL,
    "language" "LanguageEnum" NOT NULL,
    "email_updates" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "UserPrefrence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "message_id" SERIAL NOT NULL,
    "message_content" TEXT NOT NULL,
    "message_body" TEXT NOT NULL,
    "is_deleted" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "reply_to_id" INTEGER,
    "sender_user_id" INTEGER NOT NULL,
    "receiver_user_id" INTEGER NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("message_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserPrefrence_user_id_key" ON "UserPrefrence"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_uuid_key" ON "User"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- AddForeignKey
ALTER TABLE "UserPrefrence" ADD CONSTRAINT "UserPrefrence_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_sender_user_id_fkey" FOREIGN KEY ("sender_user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_receiver_user_id_fkey" FOREIGN KEY ("receiver_user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_reply_to_id_fkey" FOREIGN KEY ("reply_to_id") REFERENCES "Message"("message_id") ON DELETE SET NULL ON UPDATE CASCADE;
