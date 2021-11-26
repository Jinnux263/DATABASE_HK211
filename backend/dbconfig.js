const username = process.env.SQL_SERVER_USERNAME
const passwd = process.env.SQL_SERVER_PASSWD

const config = {
    login: {username},
    password: {passwd},
    database: 'ASSIGNMENT2',
    server: 'MSI',
    driver: 'msnodesqlv8',
    options: {
        trustedConnection: true
    }   
}
export default config; 