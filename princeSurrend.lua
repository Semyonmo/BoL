local old_vote = 0
local new = {}
    new['surr_start_end_header'] = 0x011B --
    new['surr_vote_header'] = 0x0040 --
    new['surr_vote_netid_pos'] = 15 --
    new['surr_vote_val_pos'] = 10 --
local decoded_table_4_new = { -- working for patch 5.14
    [0x01] = 0xD0,[0x02] = 0x10,[0x03] = 0x0F,[0x04] = 0xA6,[0x05] = 0x1C,[0x06] = 0xC4,[0x07] = 0xF4,[0x08] = 0x0A,
    [0x09] = 0x97,[0x0A] = 0xD9,[0x0B] = 0x65,[0x0C] = 0xB8,[0x0D] = 0x43,[0x0E] = 0x33,[0x0F] = 0xC5,[0x10] = 0xCD,
    [0x11] = 0x4F,[0x12] = 0x69,[0x13] = 0x9B,[0x14] = 0x38,[0x15] = 0x1E,[0x16] = 0x37,[0x17] = 0x6C,[0x18] = 0xA5,
    [0x19] = 0x9E,[0x1A] = 0xD8,[0x1B] = 0x30,[0x1C] = 0xD1,[0x1D] = 0x15,[0x1E] = 0x74,[0x1F] = 0xA7,[0x20] = 0x35,
    [0x21] = 0xD4,[0x22] = 0x5D,[0x23] = 0x28,[0x24] = 0x18,[0x25] = 0x5E,[0x26] = 0xDF,[0x27] = 0x22,[0x28] = 0xDB,
    [0x29] = 0xC7,[0x2A] = 0x2E,[0x2B] = 0xBB,[0x2C] = 0xE2,[0x2D] = 0x76,[0x2E] = 0x9A,[0x2F] = 0x20,[0x30] = 0x40,
    [0x31] = 0x02,[0x32] = 0xCB,[0x33] = 0x8F,[0x34] = 0xF0,[0x35] = 0x0E,[0x36] = 0x53,[0x37] = 0xBD,[0x38] = 0x93,
    [0x39] = 0xE5,[0x3A] = 0x45,[0x3B] = 0x42,[0x3C] = 0xA8,[0x3D] = 0x08,[0x3E] = 0x67,[0x3F] = 0x09,[0x40] = 0xB2,
    [0x41] = 0xFF,[0x42] = 0x9F,[0x43] = 0x4A,[0x44] = 0xC0,[0x45] = 0x5F,[0x46] = 0x5C,[0x47] = 0xE7,[0x48] = 0xFB,
    [0x49] = 0x06,[0x4A] = 0x5B,[0x4B] = 0x26,[0x4C] = 0x78,[0x4D] = 0x3A,[0x4E] = 0xEF,[0x4F] = 0x68,[0x50] = 0x2B,
    [0x51] = 0x96,[0x52] = 0x3D,[0x53] = 0x6D,[0x54] = 0xC1,[0x55] = 0x94,[0x56] = 0x63,[0x57] = 0x59,[0x58] = 0x14,
    [0x59] = 0x66,[0x5A] = 0xE3,[0x5B] = 0xA0,[0x5C] = 0xE4,[0x5D] = 0x89,[0x5E] = 0x56,[0x5F] = 0xE8,[0x60] = 0x71,
    [0x61] = 0x2D,[0x62] = 0x79,[0x63] = 0x62,[0x64] = 0xEB,[0x65] = 0x00,[0x66] = 0x13,[0x67] = 0x4C,[0x68] = 0x34,
    [0x69] = 0xC8,[0x6A] = 0xD5,[0x6B] = 0x81,[0x6C] = 0xF9,[0x6D] = 0x24,[0x6E] = 0xAF,[0x6F] = 0x70,[0x70] = 0x2A,
    [0x71] = 0xC2,[0x72] = 0xB6,[0x73] = 0xF1,[0x74] = 0x7C,[0x75] = 0x52,[0x76] = 0x51,[0x77] = 0x73,[0x78] = 0x77,
    [0x7A] = 0x0B,[0x7B] = 0x85,[0x7C] = 0x8E,[0x7D] = 0x9D,[0x7E] = 0xC9,[0x7F] = 0x86,[0x80] = 0x7E,[0x81] = 0x4E,
    [0x82] = 0xCC,[0x83] = 0x07,[0x84] = 0x23,[0x85] = 0xA1,[0x86] = 0xA9,[0x87] = 0x80,[0x88] = 0x1D,[0x89] = 0x49,
    [0x8A] = 0x36,[0x8B] = 0x1F,[0x8C] = 0xB9,[0x8D] = 0x11,[0x8E] = 0x91,[0x8F] = 0x2C,[0x90] = 0xBE,[0x91] = 0xC6,
    [0x92] = 0x17,[0x93] = 0xA3,[0x94] = 0xA4,[0x95] = 0x58,[0x96] = 0x4B,[0x97] = 0x2F,[0x98] = 0x7A,[0x99] = 0xEE,
    [0x9A] = 0xF2,[0x9B] = 0x90,[0x9C] = 0x4D,[0x9D] = 0x41,[0x9E] = 0x19,[0x9F] = 0x0D,[0xA0] = 0x87,[0xA1] = 0x55,
    [0xA2] = 0xDA,[0xA3] = 0xAC,[0xA4] = 0x8A,[0xA5] = 0xEA,[0xA6] = 0x8B,[0xA7] = 0xBF,[0xA8] = 0x50,[0xA9] = 0x92,
    [0xAA] = 0x3C,[0xAB] = 0xAA,[0xAC] = 0xFD,[0xAD] = 0x3F,[0xAE] = 0xE1,[0xAF] = 0xCA,[0xB0] = 0x3B,[0xB1] = 0x29,
    [0xB2] = 0x1B,[0xB3] = 0x6A,[0xB4] = 0x1A,[0xB5] = 0xFC,[0xB6] = 0x44,[0xB7] = 0xDC,[0xB8] = 0xF8,[0xB9] = 0x48,
    [0xBA] = 0x25,[0xBB] = 0x88,[0xBC] = 0x64,[0xBD] = 0xA2,[0xBE] = 0x99,[0xBF] = 0xE6,[0xC0] = 0xC3,[0xC1] = 0x39,
    [0xC3] = 0x8C,[0xC4] = 0xE0,[0xC5] = 0x12,[0xC6] = 0x57,[0xC7] = 0x7F,[0xC8] = 0x3E,[0xC9] = 0xD3,[0xCA] = 0x7B,
    [0xCB] = 0xEC,[0xCC] = 0xBC,[0xCD] = 0xED,[0xCE] = 0xB5,[0xCF] = 0x98,[0xD0] = 0xFA,[0xD1] = 0x6F,[0xD2] = 0x32,
    [0xD3] = 0xF5,[0xD4] = 0x5A,[0xD5] = 0x84,[0xD6] = 0x83,[0xD7] = 0xAB,[0xD8] = 0xB0,[0xD9] = 0x04,[0xDA] = 0xB3,
    [0xDB] = 0x9C,[0xDC] = 0xDE,[0xDD] = 0x75,[0xDE] = 0xD7,[0xDF] = 0xE9,[0xE0] = 0x7D,[0xE1] = 0x46,[0xE2] = 0x21,
    [0xE3] = 0x16,[0xE4] = 0xF3,[0xE5] = 0x54,[0xE6] = 0x05,[0xE7] = 0xB1,[0xE8] = 0xCE,[0xE9] = 0x8D,[0xEA] = 0xF6,
    [0xEB] = 0x31,[0xEC] = 0x03,[0xED] = 0x47,[0xEE] = 0xD6,[0xEF] = 0xCF,[0xF0] = 0xFE,[0xF1] = 0xAD,[0xF2] = 0x95,
    [0xF3] = 0xB7,[0xF4] = 0x27,[0xF5] = 0x60,[0xF6] = 0x0C,[0xF7] = 0x6B,[0xF8] = 0x01,[0xF9] = 0x82,[0xFA] = 0xF7,
    [0xFB] = 0xB4,[0xFC] = 0x61,[0xFD] = 0x6E,[0xFE] = 0xAE,[0xFF] = 0xBA,[0x00] = 0x72,
}

function OnRecvPacket(p)
    if p.header == new['surr_start_end_header'] then
        old_vote = 0
    elseif p.header == new['surr_vote_header'] then
        p.pos = new['surr_vote_netid_pos']
        local networkID = PacketDecryptF(p:DecodeF(), decoded_table_4_new)
        local who = objManager:GetObjectByNetworkId(networkID)
        
        p.pos = new['surr_vote_val_pos']
        local new_vote = p:Decode1()
        
        if old_vote == 0 or new_vote ~= old_vote then
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        else 
            voteTxt = "<font color=\"#00FF00\">NO</font>"
        end
        
        old_vote = new_vote
        
        if who then
            PrintChat("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.charName.."</font><font color=\"#00FF00\"> voted </font>"..voteTxt)
        else
            print("Error on detecting who votes, detected vote is: "..voteTxt)
        end
    end
end

function PacketDecryptF(float, mapTable)
    local dummy = CLoLPacket(0)
    dummy:EncodeF(float)
    dummy.pos = dummy.pos - 4
    local F = { dummy:Decode1(), dummy:Decode1(), dummy:Decode1(), dummy:Decode1() }
    if mapTable[F[1]] and mapTable[F[2]] and mapTable[F[3]] and mapTable[F[4]] then
        dummy:Encode1(mapTable[F[1]])
        dummy:Encode1(mapTable[F[2]])
        dummy:Encode1(mapTable[F[3]])
        dummy:Encode1(mapTable[F[4]])
        dummy.pos = dummy.pos - 4
        return dummy:DecodeF()
    end
    return 0
end

-- scriptstatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("QDGCLIKIGJK") 
--