// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhostsData {
    struct User {
        address userAddress; // user address
        uint raceId; // the race they are currently on
        uint collabId; // the collab they are currently on
        uint completedTasks; // completed tasks
        uint performance; // a percentage based on previous task performance
        uint spotTheBugs; // completed spot the bugs tasks
        uint contentPosts; // content posted
        uint ctfStbContribs; // CTF or STB contributions made
        uint ccID; // their CC id
        uint ghostsID; // their Ghosts id
    }


    struct WarmUpNFT {
        address userAddress;
        uint currentTaskId;
        uint tokenId;
        bytes32 submittedAnswers; // submitted answers by the user      
    }

    struct RaceNFT {
        bytes32 submittedAnswers; // submitted answers by the user
        bytes32 answer;
        uint performance; // performance of the user out of 100
        uint currentTaskId; 
        uint tokenId;
        address userAddress;
    }

    struct CollabNFT {
        bytes author; 
        bytes title; 
        bytes32[] answers;
        uint collabID;
        uint tokenID;
        uint currentId;
        bool completed;
        address userAddress;
    }

    struct Feat {
        bytes name; // feat name
        bytes desc; // description of feat
        bytes imageUrl; // imgUrl of image of feat
        uint256 weight; // low = 10, med = 50, high = 100
        uint256 essId; // Essence NFT ID
        uint16 essTier; // Essence Index of Tier
        uint earnedAt; // earned at timestamp
    }

    struct ProtocolFeats {
        uint256 featID; // feat ID - mapped to featsMasterList
    }

    struct UserFeats {
        address userAddress; // user address
        uint256 ccID; // CyberConnect ID
        uint followCount; // number of users following this user
        uint followerCount; // number of users this user is following
        uint commentCount; // number of comments this user has made
        uint consumeCount; // number of pieces of content consumed
        uint createCount; // number of pieces of content created
        uint[] followers;
        uint[] following;
    }

    struct MiniPost{
        address creator;
        uint creatorCCID;
        uint postId;
        uint likes;
        uint dislikes;
        bool allowComments;
        string uri;
        bytes[] comments;
    }
}
interface IGhosts {    

        function createUser(string memory handle, string[] memory hashes) external returns(uint);
        function startNextRace() external;
        function submitCompletedTask(bytes32 answers, uint perf, string calldata metadata) external;
        function getGhostsProfile(address who) external returns(IGhostsData.User memory);
         function ccGetMetadata(uint256 profileId)
        external
        view
        returns (string memory);
    function ccGetAvatar(uint256 profileId)
        external
        view
        returns (string memory);

    function ccGetSubNFTAddr(uint256 profileId)
        external
        view
        returns (address);

    function ccGetSubURI(uint256 profileId)
        external
        view
        returns (string memory);

    function ccGetEssNFTAddr(uint256 profileId, uint256 essId)
        external
        view
        returns (address);

    function ccGetEssURI(uint256 profileId, uint256 essId)
        external
        view
        returns (string memory);

    function ccSubscribe(uint256[] memory profileIDs) external;

    /**
     * @dev sets the namespace owner of the ProfileNFT to the provided address.
     * @param addr of new namespace owner
     */
    function ccSetNSOwner(address addr) external;

    function ccRegEssence(
        uint256 profileId,
        string calldata name,
        string calldata symbol,
        string calldata essenceURI,
        address essenceMw,
        bool transferable,
        bool deployAtReg
    ) external returns (uint256);

    function ccCollectEss(
        address who,
        uint256 profileId,
        uint256 essenceId
    ) external;

    function ccSetMetadata(uint256 profileId, string calldata metadata)
        external;

    function ccSetSubData(
        uint256 profileId,
        string calldata uri,
        address mw,
        bytes calldata mwData
    ) external;

    function ccSetEssData(
        uint256 profileId,
        uint256 essId,
        string calldata uri,
        address mw,
        bytes calldata mwData
    ) external;

    function ccSetPrimary(uint256 profileId) external;
     /**
     * @notice Check if the profile issued EssenceNFT is collected by me.
     *
     * @param profileId The profile id.
     * @param essenceId The essence id.
     * @param me The address to check.
     * @param _namespace The address of the ProfileNFT
     */
    function isCollectedByMe(
        uint256 profileId,
        uint256 essenceId,
        address me,
        address _namespace
    ) external view returns (bool);

    /**
     * @notice Check if the profile is subscribed by me.
     *
     * @param profileId The profile id.
     * @param me The address to check.
     * @param _namespace The address of the ProfileNFT
     */
    function isSubscribedByMe(uint256 profileId, address me, address _namespace)
        external
        view
        returns (bool);

    }