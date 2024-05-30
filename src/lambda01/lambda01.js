// hello.js

exports.handler = async (event) => {
  console.log(event);
  return 'Hello from Lambda!';
};
