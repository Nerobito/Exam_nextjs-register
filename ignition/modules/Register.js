const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// เปลี่ยนชื่อจาก "ResgiterModule" เป็น "RegisterModule" เพื่อให้ตรงกับชื่อที่ใช้ใน Smart Contract
const RegisterModule = buildModule("RegisterModule", (m) => {
  const register = m.contract("RegisterDisaster"); // เปลี่ยนชื่อจาก "Resgiter" เป็น "RegisterDisaster"

  return { register };
});

// ส่งออกโมดูลที่ถูกต้อง
module.exports = RegisterModule;
