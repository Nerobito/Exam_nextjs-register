// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner;   // เก็บข้อมูลของเจ้าของ Smart Contract (ใช้ใน Constructor)
    struct Person {
        string idCard;      // รหัสบัตรประชาชน
        string firstName;   // ชื่อ
        string lastName;    // นามสกุล
        string addr;        // ที่อยู่
    }

    Person[] private people; // สร้างตัวแปรอาเรย์ของประเภท Person เพื่อเก็บข้อมูลผู้คนที่จะลงทะเบียน
    mapping(string => uint256) private idToIndex; // สร้างตัวแปรแมพของประเภท uint256 เพื่อเก็บข้อมูลดัชนีของผู้คนตามรหัสบัตรประชาชน

    // constructor คือฟังก์ชันที่จะถูกเรียกใช้งานเมื่อมีการสร้างอินสแตนซ์ของ Smart Contract
    // msg.sender คือตัวแปรที่จะเก็บข้อมูลของผู้ที่สร้างอินสแตนซ์ของ Smart Contract
    constructor() {
        owner = msg.sender; // กำหนดค่า owner เป็นผู้ที่สร้างอินสแตนซ์
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(string memory _idCard, string memory _firstName, string memory _lastName, string memory _address) public {
        require(msg.sender == owner, "Only the owner can register a person."); // ตรวจสอบว่าผู้เรียกใช้งานคือเจ้าของ
        Person memory newPerson = Person(_idCard, _firstName, _lastName, _address); // สร้างตัวแปร newPerson จากข้อมูลที่ได้รับ
        people.push(newPerson); // เพิ่ม newPerson เข้าไปในอาเรย์ people
        idToIndex[_idCard] = people.length - 1; // กำหนดดัชนีของ newPerson ตามรหัสบัตรประชาชน
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people; // ส่งคืนอาเรย์ people ทั้งหมด
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด (ควรอ้างอิง index จากการลงทะเบียน)
    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of bounds."); // ตรวจสอบว่าดัชนีที่กำหนดไม่เกินขนาดของอาเรย์
        return people[index]; // ส่งคืนผู้เข้าร่วมตามดัชนีที่กำหนด
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    // ใช้ idToIndex เพื่อหาดัชนีของผู้เข้าร่วมที่มี idCard ตรงกัน
    function getID(string memory _idCard) public view returns (Person memory) {
        uint256 index = idToIndex[_idCard]; // หาดัชนีของผู้เข้าร่วมตามรหัสบัตรประชาชน
        require(index < people.length, "Person not found."); // ตรวจสอบว่าดัชนีที่ได้รับไม่เกินขนาดของอาเรย์
        return people[index]; // ส่งคืนผู้เข้าร่วมตามดัชนีที่ได้รับ
    }
}
