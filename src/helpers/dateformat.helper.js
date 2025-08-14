// helpers/dateformat.helper.js

/**
 * Ubah tanggal dari dd-mm-yyyy ke mm-dd-yyyy
 * @param {string} dateStr - Tanggal dalam format dd-mm-yyyy
 * @returns {string} - Format mm-dd-yyyy
 */
function convertDDMMYYYYtoMMDDYYYY(dateStr) {
    const [day, month, year] = dateStr.split('-')
    return `${month}-${day}-${year}`
}

/**
 * Ubah tanggal dari mm-dd-yyyy ke yyyy-mm-dd (untuk SQL atau Date parsing)
 * @param {string} dateStr - Tanggal dalam format mm-dd-yyyy
 * @returns {string} - Format yyyy-mm-dd
 */
function convertMMDDYYYYtoYYYYMMDD(dateStr) {
    const [month, day, year] = dateStr.split('-')
    return `${year}-${month}-${day}`
}

/**
 * Ubah tanggal dari Date object ke format mm-dd-yyyy
 * @param {string|Date} dateInput - Tanggal dalam bentuk Date object atau ISO string
 * @returns {string} - Format mm-dd-yyyy
 */
function formatDateToMMDDYYYY(dateInput) {
    const date = new Date(dateInput)
    const mm = String(date.getMonth() + 1).padStart(2, '0')
    const dd = String(date.getDate()).padStart(2, '0')
    const yyyy = date.getFullYear()
    return `${mm}-${dd}-${yyyy}`
}

/**
 * Validasi apakah string tanggal dalam format dd-mm-yyyy
 * @param {string} dateStr
 * @returns {boolean}
 */
function isValidDDMMYYYY(dateStr) {
    return /^\d{2}-\d{2}-\d{4}$/.test(dateStr)
}

module.exports = {
    convertDDMMYYYYtoMMDDYYYY,
    convertMMDDYYYYtoYYYYMMDD,
    formatDateToMMDDYYYY,
    isValidDDMMYYYY,
}
