local old_vote = 0
local new = {}
new['surr_start_end_header'] = 0x0044
new['surr_vote_header'] = 0x0051
new['surr_vote_netid_pos'] = 11
new['surr_vote_val_pos'] = 15
local decoded_table_4_new = { -- working for patch 5.12
    [0x01] = 0x5F,[0x02] = 0xCE,[0x03] = 0x87,[0x04] = 0x3C,[0x05] = 0x96,[0x06] = 0x03,[0x07] = 0x9E,
    [0x08] = 0x7B,[0x09] = 0x40,[0x0A] = 0x5A,[0x0B] = 0xF7,[0x0C] = 0x16,[0x0F] = 0xC6,[0x10] = 0x6B,
    [0x11] = 0xEE,[0x12] = 0xCC,[0x13] = 0xFB,[0x14] = 0x79,[0x15] = 0xBD,[0x16] = 0x2C,[0x17] = 0x50,
    [0x19] = 0xE9,[0x1A] = 0xDC,[0x1B] = 0x55,[0x1C] = 0xC1,[0x1D] = 0xC5,[0x1E] = 0x6D,[0x1F] = 0x62,
    [0x21] = 0x92,[0x22] = 0xEA,[0x23] = 0x1F,[0x24] = 0x31,[0x25] = 0xCF,[0x26] = 0xC3,[0x27] = 0x18,
    [0x28] = 0xE1,[0x29] = 0x3D,[0x2A] = 0x6C,[0x2C] = 0xE4,[0x2D] = 0xD6,[0x2E] = 0xB7,[0x2F] = 0xB2,
    [0x31] = 0x12,[0x32] = 0x44,[0x33] = 0x95,[0x34] = 0x1A,[0x35] = 0x74,[0x36] = 0xF1,[0x37] = 0x7D,
    [0x38] = 0x7A,[0x39] = 0x15,[0x3A] = 0x89,[0x3B] = 0x34,[0x3C] = 0x8C,[0x3D] = 0x05,[0x3E] = 0xD3,
    [0x3F] = 0x32,[0x40] = 0x4F,[0x41] = 0x85,[0x42] = 0xBE,[0x43] = 0xEF,[0x44] = 0x2A,[0x45] = 0x70,
    [0x46] = 0xB4,[0x47] = 0xD1,[0x48] = 0xDD,[0x49] = 0x1B,[0x4A] = 0xB8,[0x4B] = 0xC7,[0x4C] = 0x64,
    [0x4D] = 0x53,[0x4E] = 0xF3,[0x4F] = 0x61,[0x50] = 0x21,[0x51] = 0x9A,[0x52] = 0x23,[0x53] = 0xA9,
    [0x54] = 0x2F,[0x56] = 0xE6,[0x58] = 0x8D,[0x59] = 0xA2,[0x5A] = 0x0A,[0x5B] = 0x01,[0x5C] = 0xBF,
    [0x5D] = 0x5E,[0x5F] = 0x25,[0x60] = 0x75,[0x61] = 0x1D,[0x62] = 0xF4,[0x63] = 0x8E,[0x64] = 0xED,
    [0x65] = 0x58,[0x66] = 0x17,[0x67] = 0xB9,[0x68] = 0x9C,[0x69] = 0x68,[0x6A] = 0x33,[0x6B] = 0x8F,
    [0x6C] = 0xB0,[0x6E] = 0x11,[0x6F] = 0xFF,[0x70] = 0x4C,[0x71] = 0xF9,[0x73] = 0x5B,[0x74] = 0x2D,
    [0x75] = 0x41,[0x76] = 0xA3,[0x77] = 0xCB,[0x78] = 0x29,[0x79] = 0x83,[0x7A] = 0x4E,[0x7B] = 0x46,
    [0x7C] = 0xD4,[0x7D] = 0xB3,[0x7E] = 0xD7,[0x7F] = 0xA6,[0x80] = 0x5C,[0x81] = 0x02,[0x82] = 0x38,
    [0x83] = 0x51,[0x84] = 0x3A,[0x85] = 0xF0,[0x86] = 0x9B,[0x87] = 0x37,[0x88] = 0xD2,[0x89] = 0xBB,
    [0x8A] = 0x80,[0x8B] = 0x8B,[0x8C] = 0xC2,[0x8D] = 0xA7,[0x8E] = 0xA1,[0x8F] = 0xF8,[0x90] = 0x91,
    [0x91] = 0x84,[0x92] = 0xE2,[0x93] = 0x27,[0x94] = 0x42,[0x95] = 0xDE,[0x96] = 0x07,[0x97] = 0xCD,
    [0x98] = 0x1C,[0x99] = 0x47,[0x9A] = 0x4A,[0x9B] = 0x73,[0x9C] = 0x9D,[0x9D] = 0x28,[0x9E] = 0x69,
    [0x9F] = 0x3F,[0xA0] = 0x66,[0xA1] = 0x78,[0xA2] = 0xAD,[0xA3] = 0x6F,[0xA4] = 0xA4,[0xA5] = 0x7F,
    [0xA6] = 0x20,[0xA7] = 0x54,[0xA8] = 0x65,[0xA9] = 0x86,[0xAB] = 0x9F,[0xAC] = 0xE5,[0xAD] = 0xE7,
    [0xAE] = 0xDF,[0xAF] = 0xEB,[0xB0] = 0xB1,[0xB1] = 0xCA,[0xB2] = 0x08,[0xB3] = 0x98,[0xB4] = 0x0C,
    [0xB5] = 0xAF,[0xB6] = 0xC0,[0xB7] = 0x81,[0xB8] = 0x5D,[0xB9] = 0x49,[0xBA] = 0xE3,[0xBC] = 0xDB,
    [0xBD] = 0x52,[0xBE] = 0x35,[0xBF] = 0x43,[0xC0] = 0x4D,[0xC1] = 0x8A,[0xC2] = 0x59,[0xC3] = 0xD8,
    [0xC4] = 0x0F,[0xC5] = 0x82,[0xC6] = 0x4B,[0xC7] = 0xF2,[0xC8] = 0x19,[0xC9] = 0x60,[0xCA] = 0xBC,
    [0xCB] = 0x7E,[0xCC] = 0x36,[0xCD] = 0xA8,[0xCE] = 0x1E,[0xCF] = 0x6E,[0xD0] = 0x3B,[0xD1] = 0x77,
    [0xD2] = 0xF5,[0xD4] = 0x04,[0xD5] = 0x14,[0xD6] = 0xA5,[0xD7] = 0xEC,[0xD8] = 0xDA,[0xD9] = 0xAE,
    [0xDA] = 0x6A,[0xDB] = 0x56,[0xDC] = 0x00,[0xDD] = 0x22,[0xDE] = 0xFE,[0xDF] = 0x76,[0xE0] = 0x88,
    [0xE1] = 0xBA,[0xE2] = 0xB5,[0xE3] = 0x13,[0xE4] = 0xC9,[0xE5] = 0x06,[0xE6] = 0x26,[0xE7] = 0xAC,
    [0xE8] = 0x0E,[0xE9] = 0x45,[0xEA] = 0x67,[0xEB] = 0x72,[0xEC] = 0xFD,[0xED] = 0xB6,[0xEE] = 0x57,
    [0xEF] = 0x7C,[0xF0] = 0xF6,[0xF1] = 0x63,[0xF3] = 0xC8,[0xF4] = 0xE8,[0xF5] = 0xD9,[0xF6] = 0x39,
    [0xF7] = 0x3E,[0xF8] = 0x71,[0xFA] = 0x0D,[0xFB] = 0x99,[0xFC] = 0x24,[0xFD] = 0x10,[0xFE] = 0xAA,
    [0xFF] = 0x09,[0x00] = 0x2E,
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
        
        if old_vote == 0 then
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        elseif new_vote ~= old_vote then
            voteTxt = "<font color=\"#FF0000\">NO</font>"
        else 
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        end
        
        old_vote = new_vote
        
        if who then
            PrintChat("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.name.." ("..who.charName..")</font><font color=\"#00FF00\"> voted </font>"..voteTxt)
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