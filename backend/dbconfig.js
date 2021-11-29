const username = process.env.SQL_SERVER_USERNAME;
const passwd = process.env.SQL_SERVER_PASSWD;

// const config = {
//   user: "LAPTOP-2KEU49GH\\Nguyen Dat",
//   password: "",
//   database: "ASSIGNMENT2",
//   server: "LAPTOP-2KEU49GH",
//   driver: "msnodesqlv8",
//   options: {
//     trustedConnection: true,
//   },
//   port: 61440,
// };

const config = {
    login: {username},
    password: {passwd},
    database: 'ASSIGNMENT2',
    server: 'MSI',
    driver: 'msnodesqlv8',
    options: {
        trustedConnection: true
    }
};
export default config;
