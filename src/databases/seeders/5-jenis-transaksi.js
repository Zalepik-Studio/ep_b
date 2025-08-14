'use strict'

/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        /**
         * Add seed commands here.
         *
         * Example:
         *
         */

        await queryInterface.bulkInsert(
            'payments',
            [
                {
                    jenis_payment: 'Tunai',
                    status: false,
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
                {
                    jenis_payment: 'Bank',
                    status: false,
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
                {
                    jenis_payment: 'QRIS',
                    status: false,
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
                {
                    jenis_payment: 'Member',
                    status: false,
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
