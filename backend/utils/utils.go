package utils

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"strings"
)

func DeepCopyMap(src map[string]any) map[string]any {
	if src == nil {
		return map[string]any{}
	}
	raw, _ := json.Marshal(src)
	var dst map[string]any
	_ = json.Unmarshal(raw, &dst)
	if dst == nil {
		dst = map[string]any{}
	}
	return dst
}

// normalizeLower 将字符串去除首尾空白后转换为小写。
//
// 该函数主要用于字符串标准化处理和比较。
func NormalizeLower(s string) string {
	return strings.ToLower(strings.TrimSpace(s))
}

func GetEmailHashFilename(email string) string {
	// 步骤 A：标准化处理（极其重要！）
	normalizedEmail := NormalizeLower(email)

	// 步骤 B：计算 MD5 哈希
	hasher := md5.New()
	hasher.Write([]byte(normalizedEmail))
	hashString := hex.EncodeToString(hasher.Sum(nil))

	// 步骤 C：拼接扩展名
	return hashString + ".json"
}
