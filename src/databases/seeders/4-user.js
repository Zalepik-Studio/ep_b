'use strict'

/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        /**
         * Add seed commands here.
         *
         * Example:
         * await queryInterface.bulkInsert('People', [{
         *   name: 'John Doe',
         *   isBetaMember: false
         * }], {});
         */

        await queryInterface.bulkInsert(
            'users',
            [
                {
                    tenant_id: 1,
                    nama: 'Super Administrator',
                    jenis_kelamin: 'Laki-laki',
                    no_hp: '0834534534534',
                    alamat_lengkap: 'Jakarta',
                    username: 'admin',
                    password:
                        '$argon2id$v=19$m=65536,t=3,p=4$ZgL00fxWKE57lcZrmm8stA$pEy+jamSNgkGKjM4KAT1QTev1zP9KlRhx/RfyijVBRk',
                    perusahaan_id: 1,
                    level_pengguna_id: 1,
                    status: true,
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
            ],
            {}
        )
    },

    async down(queryInterface, Sequelize) {
        /**
         * Add commands to revert seed here.
         *
         * Example:
         * await queryInterface.bulkDelete('People', null, {});
         */
    },
}
