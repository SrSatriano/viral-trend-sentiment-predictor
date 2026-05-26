package main

import (
	"flag"
	"fmt"
	"log"
	"time"
)

func main() {
	platform := flag.String("platform", "tiktok", "tiktok|youtube")
	flag.Parse()

	log.Printf("scraper started platform=%s", *platform)
	for i := 0; i < 3; i++ {
		snapshot := map[string]any{
			"tag":        fmt.Sprintf("trend_%d", i),
			"views":      1000 * (i + 1),
			"sentiment":  0.5 + float64(i)*0.1,
			"captured_at": time.Now().UTC(),
		}
		_ = snapshot
			}
	log.Println("scraper finished")
}
