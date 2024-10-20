import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  // Create a new user
  // await prisma?.$connect();
  // await prisma.user.deleteMany();

  // const user = await prisma.user.create({
  //   data: {
  //     email: "jvLJW@example.com",
  //     password: "password",
  //     date_of_birth: new Date(),
  //     roles: [1],
  //     username: "alice",
  //     full_name: "Alice Smith",
  //     user_prefrence: {
  //       create: {
  //         theme: "LIGHT",
  //         language: "EN",
  //         email_updates: true,
  //       },
  //     },
  //   },
  //   select: {
  //     email: true,
  //     date_of_birth: true,
  //     roles: true,
  //     created_at: true,
  //     full_name: true,
  //     last_login: true,
  //     refresh_tokens: true,
  //     username: true,
  //     uuid: true,
  //     updated_at: true,
  //     user_prefrence: {
  //       select: { language: true, theme: true, email_updates: true },
  //     },
  //   },
  // });

  const user = await prisma.user.findUnique({
    where: {
      email: "jvLJW@example.com",
    },
    select: {
      email: true,
      date_of_birth: true,
      roles: true,
      created_at: true,
      full_name: true,
      last_login: true,
      refresh_tokens: true,
      username: true,
      uuid: true,
      updated_at: true,
      user_prefrence: {
        select: { language: true, theme: true, email_updates: true },
      },
    },
  });

  console.log(user);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
