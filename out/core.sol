// SPDX-License-Identifier: MIT
// produced by the Solididy File Flattener (c) David Appleton 2018 - 2020 and beyond
// contact : calistralabs@gmail.com
// source  : https://github.com/DaveAppleton/SolidityFlattery
// released under Apache 2.0 licence
// input  /home/yosimura/Documents/BlockChain/contracts/contracts/core.sol
// flattened :  Tuesday, 29-Jun-21 02:30:43 UTC
interface IConverter {
    function unwrap(
        address sourceToken,
        address destinationToken,
        uint256 amount,
        uint256 userSlippageTolerance
    ) external payable returns (uint256);

    function wrap(
        address sourceToken,
        address[] memory destinationTokens,
        uint256 amount,
        uint256 userSlippageTolerance
    ) external payable returns (address, uint256);
}

interface ITier1Staking {
    function deposit(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount,
        address onBehalfOf
    ) external payable returns (bool);

    function withdraw(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount,
        address onBehalfOf
    ) external payable returns (bool);
}

interface IWETH {
    function deposit() external payable;

    function transfer(address to, uint256 value) external returns (bool);

    function withdraw(uint256) external;
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

interface IPlexusOracle {
    function getTotalValueLockedInternalByToken(
        address tokenAddress,
        address tier2Address
    ) external view returns (uint256);

    function getTotalValueLockedAggregated(uint256 optionIndex) external view returns (uint256);

    function getStakableTokens() external view returns (address[] memory, string[] memory);

    function getAPR(address tier2Address, address tokenAddress) external view returns (uint256);

    function getAmountStakedByUser(
        address tokenAddress,
        address userAddress,
        address tier2Address
    ) external view returns (uint256);

    function getUserCurrentReward(
        address userAddress,
        address tokenAddress,
        address tier2FarmAddress
    ) external view returns (uint256);

    function getTokenPrice(address tokenAddress) external view returns (uint256);

    function getUserWalletBalance(
      address userAddress, 
      address tokenAddress
    ) external view returns (uint256);

    function getAddress(string memory) external view returns (address);
}

abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor () {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

contract OwnableUpgradeable is OwnableProxied {
    /*
     * @notice Modifier to make body of function only execute if the contract has not already been initialized.
     */
    address payable public proxy;
    modifier initializeOnceOnly() {
         if(!initialized[target]) {
             initialized[target] = true;
             emit EventInitialized(target);
             _;
         } else revert();
     }

    modifier onlyProxy() {
        require(msg.sender == proxy);
        _;
    }

    /**
     * @notice Will always fail if called. This is used as a placeholder for the contract ABI.
     * @dev This is code is never executed by the Proxy using delegate call
     */
    function upgradeTo(address) override public {
        assert(false);
    }

    /**
     * @notice Initialize any state variables that would normally be set in the contructor.
     * @dev Initialization functionality MUST be implemented in inherited upgradeable contract if the child contract requires
     * variable initialization on creation. This is because the contructor of the child contract will not execute
     * and set any state when the Proxy contract targets it.
     * This function MUST be called stright after the Upgradeable contract is set as the target of the Proxy. This method
     * can be overwridden so that it may have arguments. Make sure that the initializeOnceOnly() modifier is used to protect
     * from being initialized more than once.
     * If a contract is upgraded twice, pay special attention that the state variables are not initialized again
     */
    /*function initialize() initializeOnceOnly public {
        // initialize contract state variables here
    }*/

    function setProxy(address payable theAddress) public onlyOwner {
        proxy = theAddress;
    }
}

contract Core is OwnableUpgradeable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    // globals
    address public oracleAddress;
    address public converterAddress;
    address public stakingAddress;
    IPlexusOracle private oracle;
    ITier1Staking private staking;
    IConverter private converter;
    address public ETH_TOKEN_PLACEHOLDER_ADDRESS;
    address public WETH_TOKEN_ADDRESS;
    IWETH private wethToken;
    uint256 private approvalAmount;

    constructor() payable {
    }

    function initialize(address _weth, address _converter) initializeOnceOnly public {
        ETH_TOKEN_PLACEHOLDER_ADDRESS = address(0x0);
        WETH_TOKEN_ADDRESS = _weth;
        wethToken = IWETH(WETH_TOKEN_ADDRESS);
        approvalAmount = 1000000000000000000000000000000;
        setConverterAddress(_converter);
    }

    modifier nonZeroAmount(uint256 amount) {
        require(amount > 0, "Amount specified is zero");
        _;
    }

    fallback() external payable {
        // For the converter to unwrap ETH when delegate calling.
        // The contract has to be able to accept ETH for this reason.
        // The emergency withdrawal call is to pick any change up for these conversions.
    }

    receive() external payable {
        // receive function
    }

    function setOracleAddress(address theAddress) public onlyOwner returns (bool) {
        oracleAddress = theAddress;
        oracle = IPlexusOracle(theAddress);
        return true;
    }

    function setStakingAddress(address theAddress) public onlyOwner returns (bool) {
        stakingAddress = theAddress;
        staking = ITier1Staking(theAddress);
        return true;
    }

    function setConverterAddress(address theAddress) public onlyOwner returns (bool) {
        converterAddress = theAddress;
        converter = IConverter(theAddress);
        return true;
    }

    function deposit(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount
    ) public payable nonReentrant nonZeroAmount(amount) returns (bool) {
        IERC20 token;
        if (tokenAddress == ETH_TOKEN_PLACEHOLDER_ADDRESS) {
            wethToken.deposit{value: msg.value}();
            tokenAddress = WETH_TOKEN_ADDRESS;
            token = IERC20(tokenAddress);
        } else {
            token = IERC20(tokenAddress);
            token.safeTransferFrom(msg.sender, address(this), amount);
        }
        token.safeIncreaseAllowance(stakingAddress, 0);
        token.safeIncreaseAllowance(stakingAddress, approvalAmount);
        bool result = staking.deposit(tier2ContractName, tokenAddress, amount, msg.sender);
        require(result, "There was an issue in core with your deposit request.");
        return result;
    }

    function withdraw(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount
    ) public payable nonReentrant nonZeroAmount(amount) returns (bool) {
        bool result = staking.withdraw(tier2ContractName, tokenAddress, amount, msg.sender);
        require(result, "There was an issue in core with your withdrawal request.");
        return result;
    }

    function convert(
        address sourceToken,
        address[] memory destinationTokens,
        uint256 amount,
        uint256 userSlippageTolerance
    ) public payable nonZeroAmount(amount) returns (address, uint256) {
        if (sourceToken != ETH_TOKEN_PLACEHOLDER_ADDRESS) {
            IERC20 srcToken = IERC20(sourceToken);
            srcToken.safeTransferFrom(msg.sender, address(this), amount);
        }
        (address destinationTokenAddress, uint256 _amount) =
            converter.wrap{value: msg.value}(sourceToken, destinationTokens, amount, userSlippageTolerance);

        IERC20 dstToken = IERC20(destinationTokenAddress);
        dstToken.safeTransfer(msg.sender, _amount);
        return (destinationTokenAddress, _amount);
    }

    // deconverting is mostly for LP tokens back to another token, as these cant be simply swapped on uniswap
    function deconvert(
        address sourceToken,
        address destinationToken,
        uint256 amount,
        uint256 userSlippageTolerance
    ) public payable returns (uint256) {
        uint256 _amount = converter.unwrap{value: msg.value}(sourceToken, destinationToken, amount, userSlippageTolerance);
        IERC20 token = IERC20(destinationToken);
        token.safeTransfer(msg.sender, _amount);
        return _amount;
    }

    function getStakableTokens() public view returns (address[] memory, string[] memory) {
        (address[] memory stakableAddresses, string[] memory stakableTokenNames) = oracle.getStakableTokens();
        return (stakableAddresses, stakableTokenNames);
    }

    function getAPR(address tier2Address, address tokenAddress) public view returns (uint256) {
        uint256 result = oracle.getAPR(tier2Address, tokenAddress);
        return result;
    }

    function getTotalValueLockedAggregated(uint256 optionIndex) public view returns (uint256) {
        uint256 result = oracle.getTotalValueLockedAggregated(optionIndex);
        return result;
    }

    function getTotalValueLockedInternalByToken(
        address tokenAddress,
        address tier2Address
    ) public view returns (uint256) {
        uint256 result = oracle.getTotalValueLockedInternalByToken(tokenAddress, tier2Address);
        return result;
    }

    function getAmountStakedByUser(
        address tokenAddress,
        address userAddress,
        address tier2Address
    ) public view returns (uint256) {
        uint256 result = oracle.getAmountStakedByUser(tokenAddress, userAddress, tier2Address);
        return result;
    }

    function getUserCurrentReward(
        address userAddress,
        address tokenAddress,
        address tier2FarmAddress
    ) public view returns (uint256) {
        return oracle.getUserCurrentReward( userAddress, tokenAddress, tier2FarmAddress);
    }

    function getTokenPrice(address tokenAddress) public view returns (uint256) {
        uint256 result = oracle.getTokenPrice(tokenAddress);
        return result;
    }

    function getUserWalletBalance(address userAddress, address tokenAddress) public view returns (uint256) {
        uint256 result = oracle.getUserWalletBalance(userAddress, tokenAddress);
        return result;
    }

    function updateWETHAddress(address newAddress) public onlyOwner returns (bool) {
        WETH_TOKEN_ADDRESS = newAddress;
        wethToken = IWETH(newAddress);
        return true;
    }

    function adminEmergencyWithdrawAccidentallyDepositedTokens(
        address token,
        uint256 amount,
        address payable destination
    ) public onlyOwner returns (bool) {
        if (address(token) == ETH_TOKEN_PLACEHOLDER_ADDRESS) {
            destination.transfer(amount);
        } else {
            IERC20 token_ = IERC20(token);
            token_.safeTransfer(destination, amount);
        }

        return true;
    }
}


